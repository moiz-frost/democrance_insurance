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
FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    dob { 20.years.ago }
    email { Faker::Internet.email }
    international_phone_number { "+97155#{Faker::Number.number(digits: 7)}" }
    country { 'AE' }
    city { 'Abu Dhabi' }
  end
end
