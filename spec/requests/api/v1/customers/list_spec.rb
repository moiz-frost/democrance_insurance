# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers' do
  describe 'GET /api/v1/insurance_providers/:insurance_provider_identifier/customers' do
    let(:make_request) do
      get "/api/v1/insurance_providers/#{insurance_provider_identifier}/customers?page=#{page}&per_page=#{per_page}"
    end

    let(:page) { 1 }
    let(:per_page) { 5 }

    let(:total_customers) { 12 }

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    before do
      total_customers.times do
        create(:customer, insurance_provider: insurance_provider)
      end
    end

    context 'with valid params' do
      it 'returns success' do
        make_request
        expect(response).to have_http_status :ok
        json = response.parsed_body
        expect(json['customers'].count).to be per_page
        expect(json['meta']['total_count']).to be total_customers
      end
    end

    context 'with invalid params' do
      let(:insurance_provider_identifier) { 'incorrect' }

      it 'returns not found' do
        make_request
        expect(response).to have_http_status :not_found
      end
    end

    describe 'with pagination' do
      context 'when requesting an out of bound page to the right' do
        let(:page) { 5 }

        it 'returns PAGE_OUT_OF_BOUNDS error' do
          make_request

          json = response.parsed_body

          expect(response).to have_http_status :not_found
          expect(json['error_code']).to eq 'PAGE_OUT_OF_BOUNDS'
        end
      end

      context 'when requesting an out of bound page to the left' do
        let(:page) { 0 }

        it 'raises error' do
          expect { make_request }.to raise_error(Pagy::VariableError)
        end
      end
    end
  end
end
