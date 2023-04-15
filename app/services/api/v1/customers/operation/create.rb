# frozen_string_literal: true

module Api
  module V1
    module Customers
      module Operation
        class Create < Api::V1::Operation
          def initialize(insurance_provider_identifier:, params:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @params = params
          end

          def call
            customer = insurance_provider.customers.create!(params)

            success(json: customer, status: :created)
          end

          private

          def insurance_provider
            @insurance_provider ||= InsuranceProvider.find_by!(identifier: insurance_provider_identifier)
          end

          attr_reader :insurance_provider_identifier, :params
        end
      end
    end
  end
end
