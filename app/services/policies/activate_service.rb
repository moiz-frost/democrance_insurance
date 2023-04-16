# frozen_string_literal: true

module Policies
  class ActivateService
    def initialize(insurance_provider_identifier:, customer_identifier:, policy_identifier:)
      super()
      @insurance_provider_identifier = insurance_provider_identifier
      @customer_identifier = customer_identifier
      @policy_identifier = policy_identifier
    end

    def call
      ActiveRecord::Base.transaction do
        current_date = Date.current
        policy.active_status!
        policy.update!(effective_date: current_date, expiry_date: current_date + 1.year)
      end

      policy
    end

    private

    attr_reader :insurance_provider_identifier, :customer_identifier, :policy_identifier, :params

    def policy
      @policy ||= Policy.joins(customer: :insurance_provider)
                        .where(InsuranceProvider.arel_table[:identifier].eq(insurance_provider_identifier))
                        .where(Customer.arel_table[:identifier].eq(customer_identifier))
                        .find_by!(identifier: policy_identifier)
    end
  end
end
