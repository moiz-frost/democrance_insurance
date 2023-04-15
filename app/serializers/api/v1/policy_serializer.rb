# frozen_string_literal: true

module Api
  module V1
    class PolicySerializer < ActiveModel::Serializer
      attributes :premium, :cover, :identifier, :status, :type, :effective_date, :expiry_date

      def type
        object.policy_type.name
      end

      def premium
        {
          cents: object.premium_cents,
          currency: object.premium_currency,
          formatted: object.premium.format
        }
      end

      def cover
        {
          cents: object.cover_cents,
          currency: object.cover_currency,
          formatted: object.cover.format
        }
      end
    end
  end
end
