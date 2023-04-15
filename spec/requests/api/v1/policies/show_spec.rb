# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies' do
  describe 'POST /api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies' do
    let(:make_request) do
      get "/api/v1/insurance_providers/#{insurance_provider_identifier}/customers/#{customer_identifier}/policies/#{policy_identifier}"
    end

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    let(:customer) { create(:customer, insurance_provider: insurance_provider) }
    let(:customer_identifier) { customer.identifier }

    let(:policy) { create(:policy, customer: customer) }
    let(:policy_identifier) { policy.identifier }

    context 'with valid params' do
      it 'returns success' do
        make_request
        expect(response).to have_http_status :ok
        expect(response).to match_schema Api::V1::PolicySchema::Object
      end
    end

    context 'with invalid params' do
      let(:policy_identifier) { 'incorrect' }

      it 'returns not found' do
        make_request
        expect(response).to have_http_status :not_found
      end
    end
  end
end
