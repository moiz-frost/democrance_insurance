# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApiController
      include Concerns::Operatable

      def index
        operation = Customers::Operation::List.new(
          insurance_provider_identifier: params[:insurance_provider_identifier],
          params: params
        )

        operate(operation)
      end

      def show
        operation = Customers::Operation::Show.new(
          insurance_provider_identifier: params[:insurance_provider_identifier],
          customer_identifier: params[:identifier]
        )

        operate(operation)
      end

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
end
