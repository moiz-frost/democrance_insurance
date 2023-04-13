class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :email, presence: true, format: {
                                      with: /\A*@democrance.com\z/,
                                      message: 'has to end with "@democrance.com"'
                                    }
end
