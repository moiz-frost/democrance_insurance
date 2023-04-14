# frozen_string_literal: true

# == Schema Information
#
# Table name: policy_types
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  description  :string
#  identifier   :string           not null
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class PolicyType < ApplicationRecord
  include Identifiable

  identifier_options prefix: 'POT'

  validates :name, presence: true
end
