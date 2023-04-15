# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Operation
        class Generate < Api::V1::Operation
          def initialize(insurance_provider_identifier:, customer_identifier:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @customer_identifier = customer_identifier
          end

          def call
            policy = ::Policies::GenerateService.new(
              insurance_provider_identifier: insurance_provider_identifier,
              customer_identifier: customer_identifier
            ).call

            success(json: policy, serializer: GeneratedPolicySerializer)
          end

          private

          attr_reader :insurance_provider_identifier, :customer_identifier
        end
      end
    end
  end
end
