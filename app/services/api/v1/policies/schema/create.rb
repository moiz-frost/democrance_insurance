# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Schema
        class Create < ApplicationSchema
          define do
            required(:type).filled(Types::Custom::StrippedString)
          end
        end
      end
    end
  end
end
