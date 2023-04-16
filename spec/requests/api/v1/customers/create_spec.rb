# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers' do
  include ApiDocs::V1::Customers::Api

  describe 'POST /api/v1/insurance_providers/:insurance_provider_identifier/customers' do
    include ApiDocs::V1::Customers::Create

    let(:make_request) do
      post "/api/v1/insurance_providers/#{insurance_provider_identifier}/customers", as: :json, params: payload
    end

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    let(:payload) do
      {
        first_name: 'Test',
        last_name: 'Test',
        country: 'AE',
        city: 'Dubai',
        dob: '25/6/2000'
      }
    end

    context 'with valid params' do
      it 'returns success', :dox do
        make_request
        expect(response).to have_http_status :created
      end

      it 'creates an insurance provider', :dox do
        expect { make_request }.to change(Customer, :count).by 1
      end
    end

    context 'with incorrect identifier' do
      let(:insurance_provider_identifier) { 'incorrect' }

      it 'returns not_found', :dox do
        make_request
        expect(response).to have_http_status :not_found
      end
    end

    context 'with incorrect params' do
      let(:payload) do
        {
          last_name: 'Test',
          country: 'AE',
          city: 'Dubai',
          dob: Time.zone.today.to_s
        }
      end

      it 'returns unprocessable_entity', :dox do
        make_request
        json = response.parsed_body
        expect(json['error_code']).to eq('VALIDATION_ERROR')
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
