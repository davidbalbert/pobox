class User < ActiveRecord::Base
  has_secure_password

  has_many :accounts

  validates :nickname, presence: true

  def self.authenticate_by_email(email, password)
    account = Account.where(email: email).first
    user = account.try(:user)
    user.try(:authenticate, password) || false # forces return value to be false in all failure cases
  end
end
