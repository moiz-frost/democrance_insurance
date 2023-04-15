# frozen_string_literal: true

module Api
  module V1
    class InsuranceProviderSerializer < ActiveModel::Serializer
      attributes :identifier, :name
    end
  end
end
