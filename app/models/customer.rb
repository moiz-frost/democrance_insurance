# frozen_string_literal: true

# == Schema Information
#
# Table name: customers
#
#  id                         :bigint           not null, primary key
#  first_name                 :string           not null
#  last_name                  :string           not null
#  email                      :string
#  international_phone_number :string
#  country                    :string
#  city                       :string
#  identifier                 :string           not null
#  dob                        :date             not null
#  insurance_providers_id     :bigint
#  discarded_at               :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class Customer < ApplicationRecord
  include Discard::Model
  include Identifiable

  identifier_options prefix: 'C'

  has_paper_trail

  validates :first_name, :last_name, :dob, presence: true
end
