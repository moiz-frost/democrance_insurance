# frozen_string_literal: true

module Api
  module V1
    module InsuranceProviders
      module Contract
        class Create < ApplicationContract
          json(Schema::Create.new)
        end
      end
    end
  end
end
