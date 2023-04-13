# == Schema Information
#
# Table name: insurance_providers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  identifier   :string           not null
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :insurance_provider do
    name { Faker::Company.name }
  end
end
