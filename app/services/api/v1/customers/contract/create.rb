# frozen_string_literal: true

module Api::V1
  module Customers
    module Contract
      class Create < ApplicationContract
        json(Schema::Create.new)
      end
    end
  end
end
