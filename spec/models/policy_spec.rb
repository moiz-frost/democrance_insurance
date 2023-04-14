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
#  status           :integer          default("new"), not null
#  effective_date   :date
#  expiry_date      :date
#  discarded_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Policy do
  subject(:policy) { build(:policy) }

  it 'has a valid factory' do
    expect(policy).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:policy_type) }
  end

  describe '#activate!' do
    it 'activates a policy' do
      expect { policy.activate! }.to change(policy, :status).to('active')
    end
  end
end
