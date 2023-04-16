# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:identifier' do
  include ApiDocs::V1::InsuranceProviders::Api

  describe 'GET /api/v1/insurance_providers/:identifier' do
    include ApiDocs::V1::InsuranceProviders::Show

    let(:make_request) { get "/api/v1/insurance_providers/#{insurance_provider_identifier}" }

    let(:insurance_provider) { create(:insurance_provider) }
    let(:insurance_provider_identifier) { insurance_provider.identifier }

    context 'with valid params' do
      it 'returns success', :dox do
        make_request
        expect(response).to have_http_status :ok
        expect(response).to match_schema Api::V1::InsuranceProviderSchema::Object
      end
    end

    context 'with invalid params' do
      let(:insurance_provider_identifier) { 'incorrect' }

      it 'returns not found', :dox do
        make_request
        expect(response).to have_http_status :not_found
      end
    end
  end
end
