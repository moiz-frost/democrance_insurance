# frozen_string_literal: true

module Api
  module V1
    module ApiErrors
      extend ActiveSupport::Concern
      include AbstractController::Translation

      included do
        private

        def api_error(error:, status: nil, message: nil, details: nil, **extra)
          return api_custom_json_error(status: status, json: extra[:custom_json]) if extra[:custom_json].present?

          json = {
            error_code: t("api_errors.#{error}.code"),
            message: message || t("api_errors.#{error}.message"),
            details: details || t("api_errors.#{error}.details", default: nil) || []
          }.merge(extra)

          status ||= t("api_errors.#{error}.status")

          render status: status, json: json
        end

        def api_custom_json_error(status:, json:)
          render status: status, json: json
        end

        def validation_error(model)
          api_error(error: :validation_error, details: model.errors.full_messages)
        end

        def dry_error(contract)
          no_params = t('dry_validation.errors.rules.no_params_provided')
          return api_error(error: :parameter_missing, message: no_params) if contract.errors[nil] == [no_params]

          api_error(error: :validation_error, message: 'See details', details: contract_errors(contract))
        end

        def contract_errors(contract)
          errors = contract.errors.to_h.deep_dup
          errors[:base] = errors.delete(nil) if errors[nil]
          errors
        end

        def not_found!
          api_error(error: :not_found)
        end

        def pagy_overflow!
          api_error(error: :page_out_of_bounds)
        end

        def record_not_found!
          api_error(error: :record_not_found)
        end
      end
    end
  end
end
