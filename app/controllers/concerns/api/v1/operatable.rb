# frozen_string_literal: true

module Api::V1
  module Operatable
    extend ActiveSupport::Concern

    included do
      private

      def validate_and_operate(contract, operation_instance)
        return dry_error(contract) if contract.failure?

        operation = operation_instance.call
        return api_error(**operation.error) if operation.failure?

        render operation.result
      end

      def operate(operation_instance)
        operation = operation_instance.call
        return api_error(**operation.error) if operation.failure?

        render operation.result
      end
    end
  end
end
