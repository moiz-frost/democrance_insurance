# frozen_string_literal: true

module Api
  module V1
    class PoliciesController < ApiController
      include Concerns::Operatable

      def index
        operation = Policies::Operation::List.new(
          insurance_provider_identifier: params[:insurance_provider_identifier],
          customer_identifier: params[:customer_identifier]
        )

        operate(operation)
      end

      def show
        operation = Policies::Operation::Show.new(
          insurance_provider_identifier: params[:insurance_provider_identifier],
          customer_identifier: params[:customer_identifier],
          policy_identifier: params[:identifier]
        )

        operate(operation)
      end

      def create
        contract = Policies::Contract::Create.new.call(params.to_unsafe_h)
        operation = Policies::Operation::Create.new(
          params: contract.to_h.except(:insurance_provider_identifier),
          insurance_provider_identifier: params[:insurance_provider_identifier],
          customer_identifier: params[:customer_identifier]
        )

        validate_and_operate(contract, operation)
      end

      def generate
        operation = Policies::Operation::Generate.new(
          insurance_provider_identifier: params[:insurance_provider_identifier],
          customer_identifier: params[:customer_identifier]
        )

        operate(operation)
      end

      def quote
        contract = Policies::Contract::Quote.new.call(params.to_unsafe_h)
        operation = Policies::Operation::Quote.new(
          insurance_provider_identifier: params[:insurance_provider_identifier],
          customer_identifier: params[:customer_identifier],
          policy_identifier: params[:identifier],
          params: contract.to_h.except(:insurance_provider_identifier, :customer_identifier, :identifier)
        )

        operate(operation)
      end

      def activate
        operation = Policies::Operation::Activate.new(
          insurance_provider_identifier: params[:insurance_provider_identifier],
          customer_identifier: params[:customer_identifier],
          policy_identifier: params[:identifier]
        )

        operate(operation)
      end
    end
  end
end
