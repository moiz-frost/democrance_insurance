# frozen_string_literal: true

module Api
  module V1
    module InsuranceProviders
      module Operation
        class Show < Api::V1::Operation
          def initialize(insurance_provider_identifier:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
          end

          def call
            insurance_provider = InsuranceProvider.find_by!(identifier: insurance_provider_identifier)

            success(json: insurance_provider)
          end

          private

          attr_reader :insurance_provider_identifier
        end
      end
    end
  end
end
