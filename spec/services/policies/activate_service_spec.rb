# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Policies::ActivateService do
  let(:insurance_provider) { create(:insurance_provider) }
  let(:insurance_provider_identifier) { insurance_provider.identifier }

  let(:customer) { create(:customer, dob: 20.years.ago, insurance_provider: insurance_provider) }
  let(:customer_identifier) { customer.identifier }

  let(:policy) { create(:policy, customer: customer) }
  let(:policy_identifier) { policy.identifier }

  let(:args) do
    {
      insurance_provider_identifier: insurance_provider_identifier,
      customer_identifier: customer_identifier,
      policy_identifier: policy_identifier
    }
  end

  let(:service) { described_class.new(args) }

  describe '#call' do
    context 'when policy is activated' do
      before do
        Timecop.freeze
      end

      after do
        Timecop.return
      end

      it 'returns a policy with the correct status and dates' do
        service.call
        expect(policy.reload).to have_attributes(
          status: 'active',
          effective_date: Date.current,
          expiry_date: Date.current + 1.year
        )
      end
    end
  end
end
