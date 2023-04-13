# == Schema Information
#
# Table name: customers
#
#  id                         :bigint           not null, primary key
#  first_name                 :string           not null
#  last_name                  :string           not null
#  dob                        :string           not null
#  email                      :string
#  international_phone_number :string
#  country                    :string
#  city                       :string
#  identifier                 :string           not null
#  insurance_providers_id     :bigint
#  discarded_at               :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class Customer < ApplicationRecord
  include Discard::Model
  include Identifiable

  identifier_options prefix: 'C'

  validates :first_name, :last_name, :dob, presence: true
end
