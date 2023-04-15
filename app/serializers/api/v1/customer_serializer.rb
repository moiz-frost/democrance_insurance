# frozen_string_literal: true

module Api
  module V1
    class CustomerSerializer < ActiveModel::Serializer
      attributes :identifier, :first_name, :last_name, :email, :international_phone_number, :dob, :country, :city
    end
  end
end
