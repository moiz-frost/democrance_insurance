# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Operation
        class Quote < Api::V1::Operation
          def initialize(insurance_provider_identifier:, customer_identifier:, policy_identifier:, params:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @customer_identifier = customer_identifier
            @policy_identifier = policy_identifier
            @params = params
          end

          def call
            ActiveRecord::Base.transaction do
              policy.update!(params)
              policy.quoted_status!
            end

            success(json: policy)
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
    end
  end
end
