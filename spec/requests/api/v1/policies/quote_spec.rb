# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies/:policy_identifier/quote' do
  describe 'PATCH /api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies/:policy_identifier/quote' do
    let(:make_request) do
      patch "/api/v1/insurance_providers/#{insurance_provider_identifier}/customers/#{customer_identifier}/policies/#{policy_identifier}/quote",
            as: :json, params: payload
    end

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    let(:customer) { create(:customer, insurance_provider: insurance_provider) }
    let(:customer_identifier) { customer.identifier }

    let(:policy) { create(:policy, customer: customer) }
    let(:policy_identifier) { policy.identifier }

    let(:payload) do
      {
        premium_cents: 100_00,
        premium_currency: 'USD',
        cover_cents: 20_00,
        cover_currency: 'USD'
      }
    end

    context 'with valid params' do
      it 'returns success' do
        make_request
        expect(response).to have_http_status :ok
        expect(policy.reload).to have_attributes(
          premium_cents: 100_00,
          premium_currency: 'USD',
          cover_cents: 20_00,
          cover_currency: 'USD',
          status: 'quoted'
        )
      end
    end

    context 'with incorrect identifier' do
      let(:customer) { create(:customer) }
      let(:customer_identifier) { customer.identifier }

      it 'returns not_found' do
        make_request
        expect(response).to have_http_status :not_found
      end
    end
  end
end
