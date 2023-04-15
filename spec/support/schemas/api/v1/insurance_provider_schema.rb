# frozen_string_literal: true

module Api
  module V1
    module InsuranceProviderSchema
      Object = Dry::Schema.JSON do
        config.validate_keys = true

        required(:name).value(:string)
        required(:identifier).value(:string)
      end

      List = Dry::Schema.JSON do
        config.validate_keys = true

        required(:data).array(Object)
      end
    end
  end
end
