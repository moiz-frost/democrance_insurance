# frozen_string_literal: true

module Api
  module V1
    module GeneratedPolicySchema
      Object = Dry::Schema.JSON do
        config.validate_keys = true

        required(:premium).schema do
          required(:cents).filled(:integer)
          required(:currency).filled(:string)
          required(:formatted).filled(:string)
        end
        required(:cover).schema do
          required(:cents).filled(:integer)
          required(:currency).filled(:string)
          required(:formatted).filled(:string)
        end
      end

      List = Dry::Schema.JSON do
        config.validate_keys = true

        required(:data).array(Object)
      end
    end
  end
end
