# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::InsuranceProviderSerializer do
  let(:insurance_provider) { create(:insurance_provider) }
  let(:serializer) { described_class.new(insurance_provider) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer, adapter: :attributes).to_json }

  it 'matches schema' do
    expect(serialization).to match_json_string_schema Api::V1::InsuranceProviderSchema::Object
  end
end
