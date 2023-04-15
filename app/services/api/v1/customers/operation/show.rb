# frozen_string_literal: true

module Api
  module V1
    module Customers
      module Operation
        class Show < Api::V1::Operation
          def initialize(insurance_provider_identifier:, customer_identifier:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @customer_identifier = customer_identifier
          end

          def call
            customer = insurance_provider.customers.find_by!(identifier: customer_identifier)

            success(json: customer)
          end

          private

          def insurance_provider
            @insurance_provider ||= InsuranceProvider.find_by!(identifier: insurance_provider_identifier)
          end

          attr_reader :insurance_provider_identifier, :customer_identifier
        end
      end
    end
  end
end