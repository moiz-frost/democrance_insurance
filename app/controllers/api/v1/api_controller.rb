# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      include Concerns::ExceptionHandler
      include Concerns::ApiErrors

      def routing_error!
        not_found!
      end

      def ok_api_response(msg = nil)
        render json: { ok: true, msg: msg }
      end
    end
  end
end
