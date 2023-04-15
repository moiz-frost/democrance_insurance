# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CustomerSerializer do
  let(:customer) { create(:customer) }
  let(:serializer) { described_class.new(customer) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer, adapter: :attributes).to_json }

  it 'matches schema' do
    expect(serialization).to match_json_string_schema Api::V1::CustomerSchema::Object
  end
end
