# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Operation
        class Activate < Api::V1::Operation
          def initialize(insurance_provider_identifier:, customer_identifier:, policy_identifier:)
            super()
            @insurance_provider_identifier = insurance_provider_identifier
            @customer_identifier = customer_identifier
            @policy_identifier = policy_identifier
          end

          def call
            policy = ::Policies::ActivateService.new(
              insurance_provider_identifier: insurance_provider_identifier,
              customer_identifier: customer_identifier,
              policy_identifier: policy_identifier
            ).call

            success(json: policy)
          end

          private

          attr_reader :insurance_provider_identifier, :customer_identifier, :policy_identifier, :params
        end
      end
    end
  end
end
