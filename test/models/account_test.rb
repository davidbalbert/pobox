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

  test "should authenticate if credentials are correct" do
    a = accounts(:david)
    u = a.user
    u2 = User.authenticate_by_email(a.email, "secret")
    assert_equal u, u2
  end

  test "shouldn't authenticate if password is incorrect" do
    a = accounts(:david)
    assert_equal false, User.authenticate_by_email(a.email, "incorrect")
  end

  test "should't authenticate if email is incorrect" do
    assert_equal false, User.authenticate_by_email("nobody@example.com", "secret")
  end
end
