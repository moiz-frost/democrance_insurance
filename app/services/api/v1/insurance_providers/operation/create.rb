# frozen_string_literal: true

module Api
  module V1
    module InsuranceProviders
      module Operation
        class Create < Api::V1::Operation
          def initialize(params:)
            super()
            @params = params
          end

          def call
            insurance_provider = InsuranceProvider.create!(params)

            success(json: insurance_provider, status: :created)
          end

          private

          attr_reader :params
        end
      end
    end
  end
end
