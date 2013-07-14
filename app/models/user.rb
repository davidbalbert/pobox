class User < ActiveRecord::Base
  has_secure_password

  has_many :accounts

  validates :nickname, presence: true
end
