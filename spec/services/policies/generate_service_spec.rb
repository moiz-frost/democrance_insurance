# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Policies::GenerateService do
  let(:insurance_provider) { create(:insurance_provider) }
  let(:insurance_provider_identifier) { insurance_provider.identifier }

  let(:customer) { create(:customer, dob: 20.years.ago, insurance_provider: insurance_provider) }
  let(:customer_identifier) { customer.identifier }

  let(:args) do
    {
      insurance_provider_identifier: insurance_provider_identifier,
      customer_identifier: customer_identifier
    }
  end

  let(:service) { described_class.new(args) }

  describe '#call' do
    context 'when policy count is zero' do
      it 'returns a policy with correct premium and cover' do
        policy = service.call
        expect(policy.premium_cents).to eq(120_000)
        expect(policy.cover_cents).to eq(360_00)
      end
    end

    context 'when policy count is 50' do
      before do
        50.times do
          create(:policy, customer: customer)
        end
      end

      it 'returns a policy with correct premium and cover with discount capped at 20%' do
        policy = service.call
        expect(policy.premium_cents).to eq(240_00)
        expect(policy.cover_cents).to eq(72_00)
      end
    end

    context 'when customer is 50 years old' do
      before do
        customer.update!(dob: 50.years.ago)
      end

      it 'returns a policy with correct premium and cover with discount capped at 20%' do
        policy = service.call
        expect(policy.premium_cents).to eq(150_000)
        expect(policy.cover_cents).to eq(450_00)
      end
    end
  end
end
