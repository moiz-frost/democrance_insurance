# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :email, presence: true, format: {
    with: /\A*@democrance.com\z/,
    message: I18n.t('admin_user.errors.email_has_to_end_with_democrance')
  }
end
