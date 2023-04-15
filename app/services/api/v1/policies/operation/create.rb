# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Operation
        class Create < Api::V1::Operation
          def initialize(insurance_provider_identifier:, customer_identifier:, params:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @customer_identifier = customer_identifier
            @params = params
          end

          def call
            policy_type = PolicyType.find_or_create_by!(name: params[:type])
            policy = customer.policies.create!(policy_type: policy_type)

            success(json: policy, status: :created)
          end

          private

          def customer
            @customer ||= Customer.joins(:insurance_provider)
                                  .where(InsuranceProvider.arel_table[:identifier].eq(insurance_provider_identifier))
                                  .find_by!(identifier: customer_identifier)
          end

          attr_reader :insurance_provider_identifier, :customer_identifier, :params
        end
      end
    end
  end
end
