# frozen_string_literal: true

module Api
  module V1
    module CustomerSchema
      Object = Dry::Schema.JSON do
        config.validate_keys = true

        required(:identifier).value(:string)
        required(:first_name).value(:string)
        required(:last_name).value(:string)
        required(:email).value(:string)
        required(:international_phone_number).value(:string)
        required(:country).value(:string)
        required(:city).value(:string)
        required(:dob).value(:string)
      end

      List = Dry::Schema.JSON do
        config.validate_keys = true

        required(:data).array(Object)
      end
    end
  end
end
