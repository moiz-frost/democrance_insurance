# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/insurance_providers/:insurance_provider_identifier/customers' do
  describe 'POST /api/v1/insurance_providers/:insurance_provider_identifier/customers' do
    let(:make_request) do
      post "/api/v1/insurance_providers/#{insurance_provider.identifier}/customers", as: :json, params: payload
    end

    let(:insurance_provider) { create(:insurance_provider) }

    let(:payload) do
      {
        first_name: 'Test',
        last_name: 'Test',
        country: 'AE',
        city: 'Dubai',
        dob: Time.zone.today
      }
    end

    context 'with valid params' do
      it 'returns success' do
        make_request
        expect(response).to have_http_status :created
      end

      it 'creates an insurance provider' do
        expect { make_request }.to change(Customer, :count).by 1
      end
    end
  end
end
