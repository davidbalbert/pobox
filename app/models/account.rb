class Account < ActiveRecord::Base
  belongs_to :user

  validates :email, presence: true
end
