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
class Policy < ApplicationRecord
  include Identifiable
  include Discard::Model

  identifier_options prefix: 'PO'

  has_paper_trail

  monetize :premium_cents, :cover_cents

  belongs_to :policy_type
  belongs_to :customer

  enum status: {
    new: 0,
    quoted: 1,
    active: 2
  }, _suffix: true

  def activate!
    active_status!
  end
end
