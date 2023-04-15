# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Operation
        class List < Api::V1::Operation
          def initialize(insurance_provider_identifier:, customer_identifier:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @customer_identifier = customer_identifier
          end

          def call
            policies = customer.policies

            success(
              status: :ok,
              json: policies,
              include: '**',
              each_serializer: PolicySerializer,
              adapter: :json
            )
          end

          private

          attr_reader :insurance_provider_identifier, :customer_identifier

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
