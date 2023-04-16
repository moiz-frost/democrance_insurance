# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies' do
  include ApiDocs::V1::Policies::Api

  describe 'POST /api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies' do
    include ApiDocs::V1::Policies::Create

    let(:make_request) do
      post "/api/v1/insurance_providers/#{insurance_provider_identifier}/customers/#{customer_identifier}/policies",
           as: :json, params: payload
    end

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    let(:customer) { create(:customer, insurance_provider: insurance_provider) }
    let(:customer_identifier) { customer.identifier }

    let(:payload) do
      {
        type: 'car-policy'
      }
    end

    context 'with valid params' do
      it 'returns success', :dox do
        make_request
        expect(response).to have_http_status :created
      end

      it 'creates an insurance provider', :dox do
        expect { make_request }.to(
          change(Policy, :count).by(1)
          .and(
            change(PolicyType, :count).by(1)
          )
        )
      end
    end

    context 'with incorrect identifier' do
      let(:customer) { create(:customer) }
      let(:customer_identifier) { customer.identifier }

      it 'returns not_found', :dox do
        make_request
        expect(response).to have_http_status :not_found
      end
    end

    context 'with incorrect params' do
      let(:payload) do
        {}
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
