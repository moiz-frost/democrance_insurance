# frozen_string_literal: true

module Api::V1
  class CustomersController < ApiController
    include Operatable

    def index; end

    def show; end

    def create
      contract = Customers::Contract::Create.new.call(params.to_unsafe_h)
      operation = Customers::Operation::Create.new(
        params: contract.to_h.except(:insurance_provider_identifier),
        insurance_provider_identifier: params['insurance_provider_identifier']
      )

      validate_and_operate(contract, operation)
    end
  end
end
