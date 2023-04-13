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
require 'rails_helper'

RSpec.describe InsuranceProvider, type: :model do
  subject(:insurance_provider) { build(:insurance_provider) }

  it 'has a valid factory' do
    expect(insurance_provider).to be_valid
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
