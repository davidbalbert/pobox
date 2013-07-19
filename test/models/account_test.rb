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

  test "should have a unique email" do
    account1 = Account.create(@account_attributes)
    account2 = Account.new(@account_attributes)
    assert !account2.valid?, "Account was valid with a non-unique email"
  end
end
