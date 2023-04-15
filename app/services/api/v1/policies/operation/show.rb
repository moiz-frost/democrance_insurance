# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Operation
        class Show < Api::V1::Operation
          def initialize(insurance_provider_identifier:, customer_identifier:, policy_identifier:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @customer_identifier = customer_identifier
            @policy_identifier = policy_identifier
          end

          def call
            policy = customer.policies.find_by!(identifier: policy_identifier)

            success(json: policy)
          end

          private

          attr_reader :insurance_provider_identifier, :customer_identifier, :policy_identifier

          def customer
            @customer ||= Customer.joins(:insurance_provider)
                                  .where(InsuranceProvider.arel_table[:identifier].eq(insurance_provider_identifier))
                                  .find_by!(identifier: customer_identifier)
          end
        end
      end
    end
  end
end
