# frozen_string_literal: true

module Api
  module V1
    module Policies
      module Schema
        class Quote < ApplicationSchema
          define do
            optional(:premium_cents).filled(:integer)
            optional(:premium_currency).filled(Types::Custom::StrippedString)
            optional(:cover_cents).filled(:integer)
            optional(:cover_currency).filled(Types::Custom::StrippedString)
          end
        end
      end
    end
  end
end
