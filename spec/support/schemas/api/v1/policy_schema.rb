# frozen_string_literal: true

module Api
  module V1
    module PolicySchema
      Object = Dry::Schema.JSON do
        config.validate_keys = true

        required(:identifier).value(:string)
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
        required(:status).filled(:string)
        required(:type).filled(:string)
        required(:effective_date).maybe(:string)
        required(:expiry_date).maybe(:string)
      end

      List = Dry::Schema.JSON do
        config.validate_keys = true

        required(:data).array(Object)
      end
    end
  end
end
