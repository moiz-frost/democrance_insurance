# frozen_string_literal: true

module Api::V1
  class ApiController < ActionController::API
    include ExceptionHandler
    include ApiErrors

    def routing_error
      not_found!
    end

    def ok_api_response(msg = nil)
      render json: { ok: true, msg: msg }
    end
  end
end
