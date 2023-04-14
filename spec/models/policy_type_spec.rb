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
require 'rails_helper'

RSpec.describe PolicyType do
  subject(:policy_type) { build(:policy_type) }

  it 'has a valid factory' do
    expect(policy_type).to be_valid
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
