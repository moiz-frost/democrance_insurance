# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies/:policy_identifier/activate' do
  describe 'PATCH /api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies/:policy_identifier/activate' do
    let(:make_request) do
      patch "/api/v1/insurance_providers/#{insurance_provider_identifier}/customers/#{customer_identifier}/policies/#{policy_identifier}/activate", as: :json
    end

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    let(:customer) { create(:customer, insurance_provider: insurance_provider) }
    let(:customer_identifier) { customer.identifier }

    let(:policy) { create(:policy, customer: customer) }
    let(:policy_identifier) { policy.identifier }

    let(:activate_service) do
      instance_double(Policies::ActivateService, call: {})
    end

    before do
      allow(Policies::ActivateService).to receive(:new).and_return(activate_service)
      allow(activate_service).to receive(:call).and_return(policy)
    end

    context 'with valid params' do
      it 'returns success' do
        make_request
        expect(response).to have_http_status :ok
      end
    end
  end
end
