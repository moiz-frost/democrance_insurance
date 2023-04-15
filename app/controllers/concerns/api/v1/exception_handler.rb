# frozen_string_literal: true

module Api
  module V1
    module ExceptionHandler
      extend ActiveSupport::Concern

      included do
        rescue_from ActionController::ParameterMissing do |e|
          api_error(error: :parameter_missing, message: e.message)
        end

        rescue_from ActiveModel::ValidationError do |e|
          api_error(error: :validation_error, details: e.model.errors.full_messages)
        end

        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found!
        rescue_from Pagy::OverflowError, with: :pagy_overflow!
      end
    end
  end
end
