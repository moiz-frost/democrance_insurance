# frozen_string_literal: true

module Api::V1
  class OperationResult
    attr_reader :result, :error

    def initialize(result: nil, error: nil)
      @result = result
      @error = error
    end

    def success?
      error.nil?
    end

    def failure?
      !success?
    end

    def with_context(context)
      if success?
        updated_context = (@result.dig(:json, :context) || {}).merge(context)
        @result[:json] = (@result[:json] || {}).merge(context: updated_context)
      else
        updated_context = (@error[:context] || {}).merge(context)
        @error[:context] = updated_context
      end
      self
    end
  end
end
