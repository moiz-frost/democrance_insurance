# frozen_string_literal: true

module Api
  module V1
    class ApplicationContract < Dry::Validation::Contract
      config.messages.backend = :i18n
    end
  end
end
