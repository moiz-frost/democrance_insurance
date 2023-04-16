# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies' do
  include ApiDocs::V1::Policies::Api

  describe 'GET /api/v1/insurance_providers/:insurance_provider_identifier/customers/:customer_identifier/policies' do
    include ApiDocs::V1::Policies::List

    let(:make_request) do
      get "/api/v1/insurance_providers/#{insurance_provider_identifier}/customers/#{customer_identifier}/policies"
    end

    let(:total_policies) { 12 }

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    let(:customer) { create(:customer, insurance_provider: insurance_provider) }
    let(:customer_identifier) { customer.identifier }

    before do
      total_policies.times do
        create(:policy, customer: customer)
      end
    end

    context 'with valid params' do
      it 'returns success', :dox do
        make_request
        expect(response).to have_http_status :ok
        json = response.parsed_body
        expect(json['policies'].count).to be total_policies
      end
    end

    context 'with invalid params' do
      let(:customer_identifier) { 'incorrect' }

      it 'returns not found', :dox do
        make_request
        expect(response).to have_http_status :not_found
      end
    end
  end
end
