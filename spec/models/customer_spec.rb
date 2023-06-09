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
#  insurance_provider_id      :bigint
#  discarded_at               :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
require 'rails_helper'

RSpec.describe Customer do
  subject(:customer) { create(:customer) }

  it 'has a valid factory' do
    expect(customer).to be_valid
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:dob) }

    it 'invalidates the record if identifier is changed' do
      customer.identifier = 'xyz'
      expect(customer).to be_invalid
    end
  end

  describe '#age' do
    before do
      customer.dob = 50.years.ago
    end

    it {
      expect(customer).to have_attributes(
        age: 50
      )
    }
  end
end
