# frozen_string_literal: true

module Api::V1
  module InsuranceProviders
    module Schema
      class Create < ApplicationSchema
        define do
          required(:name).filled(:string)
        end
      end
    end
  end
end
