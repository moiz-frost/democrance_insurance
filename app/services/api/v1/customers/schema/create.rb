# frozen_string_literal: true

module Api::V1
  module Customers
    module Schema
      class Create < ApplicationSchema
        define do
          required(:first_name).filled(Types::Custom::StrippedString)
          required(:last_name).filled(Types::Custom::StrippedString)
          required(:country).filled(:string)
          required(:city).filled(:string)
          required(:dob).filled(Types::Params::Date)
          optional(:email).filled(:string)
          optional(:international_phone_number).filled(:string)
        end
      end
    end
  end
end
