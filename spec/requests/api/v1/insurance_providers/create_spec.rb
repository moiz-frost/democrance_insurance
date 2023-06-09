# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers' do
  include ApiDocs::V1::InsuranceProviders::Api

  describe 'POST /api/v1/insurance_providers' do
    include ApiDocs::V1::InsuranceProviders::Create

    let(:make_request) { post '/api/v1/insurance_providers', as: :json, params: payload }

    let(:payload) do
      {
        name: 'Provider'
      }
    end

    context 'with valid params' do
      it 'returns success', :dox do
        make_request
        expect(response).to have_http_status :created
      end

      it 'creates an insurance provider', :dox do
        expect { make_request }.to change(InsuranceProvider, :count).by 1
      end
    end
  end
end
