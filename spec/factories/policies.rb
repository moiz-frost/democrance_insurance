# frozen_string_literal: true

# == Schema Information
#
# Table name: policies
#
#  id               :bigint           not null, primary key
#  premium_cents    :integer          default(0), not null
#  premium_currency :string           default("USD"), not null
#  cover_cents      :integer          default(0), not null
#  cover_currency   :string           default("USD"), not null
#  identifier       :string           not null
#  policy_type_id   :bigint
#  customer_id      :bigint
#  status           :integer          default("new"), not null
#  effective_date   :date
#  expiry_date      :date
#  discarded_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :policy do
    premium_cents { rand(0..5_000_000) }
    premium_currency { 'AED' }
    cover_cents { rand(0..500_000) }
    cover_currency { 'AED' }
    policy_type
  end
end
