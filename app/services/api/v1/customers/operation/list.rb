# frozen_string_literal: true

module Api
  module V1
    module Customers
      module Operation
        class List < Api::V1::Operation
          include Concerns::Paginatable

          def initialize(insurance_provider_identifier:, params: [])
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @params = params
          end

          def call
            pagy, customers = fetch_insurance_provider_customers

            success(
              status: :ok,
              json: customers,
              meta: pagination_meta(pagy),
              include: '**',
              each_serializer: CustomerSerializer,
              adapter: :json
            )
          end

          private

          attr_reader :insurance_provider_identifier, :params

          def fetch_insurance_provider_customers
            pagy, customers = pagy(insurance_provider.customers)

            [pagy, customers]
          end

          def insurance_provider
            @insurance_provider ||= InsuranceProvider.find_by!(identifier: insurance_provider_identifier)
          end
        end
      end
    end
  end
end
