require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @account_attributes = {email: 'dave@example.com'}
  end

  test "is valid proper attributes" do
    account = Account.new(@account_attributes)
    assert account.valid?
  end

  test "is not valid without email" do
    account = Account.new(@account_attributes.except(:email))
    assert !account.valid?, "Account was valid without an email"
  end
end
