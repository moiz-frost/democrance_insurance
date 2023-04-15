# frozen_string_literal: true

module Api
  module V1
    # Base class for returning operation execution results that are ready to be consumed by API controller
    class Operation
      private

      def failure(error)
        OperationResult.new(error: error)
      end

      def success(result = nil)
        OperationResult.new(result: result)
      end
    end
  end
end
