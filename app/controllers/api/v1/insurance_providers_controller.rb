# frozen_string_literal: true

module Api
  module V1
    class InsuranceProvidersController < ApiController
      include Concerns::Operatable

      def show
        operation = InsuranceProviders::Operation::Show.new(insurance_provider_identifier: params[:identifier])

        operate(operation)
      end

      def create
        contract = InsuranceProviders::Contract::Create.new.call(params.to_unsafe_h)
        operation = InsuranceProviders::Operation::Create.new(params: contract.to_h)

        validate_and_operate(contract, operation)
      end
    end
  end
end
