# frozen_string_literal: true

module Api::V1
  class InsuranceProvidersController < ApiController
    include Operatable

    def index; end

    def show; end

    def create
      contract = InsuranceProviders::Contract::Create.new.call(params.to_unsafe_h)
      operation = InsuranceProviders::Operation::Create.new(params: contract.to_h)

      validate_and_operate(contract, operation)
    end
  end
end
