# frozen_string_literal: true

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
class InsuranceProvider < ApplicationRecord
  include Discard::Model
  include Identifiable

  identifier_options prefix: 'IP'

  validates :name, presence: true
end
