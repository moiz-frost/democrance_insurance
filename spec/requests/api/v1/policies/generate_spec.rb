# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies/generate' do
  describe 'POST /api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies/generate' do
    let(:make_request) do
      get "/api/v1/insurance_providers/#{insurance_provider_identifier}/customers/#{customer_identifier}/policies/generate"
    end

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    let(:customer) { create(:customer, insurance_provider: insurance_provider) }
    let(:customer_identifier) { customer.identifier }

    let(:policy) do
      Policy.new(premium: Money.from_amount(1000), cover: Money.from_amount(1000))
    end

    let(:generate_service) do
      instance_double(Policies::GenerateService, call: {})
    end

    before do
      allow(Policies::GenerateService).to receive(:new).and_return(generate_service)
      allow(generate_service).to receive(:call).and_return(policy)
    end

    context 'with valid params' do
      it 'returns success' do
        make_request
        expect(response).to have_http_status :ok
        expect(response).to match_schema Api::V1::GeneratedPolicySchema::Object
      end
    end
  end
end
