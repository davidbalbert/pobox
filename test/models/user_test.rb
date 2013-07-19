require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user_attributes = {nickname: 'dave',
                        password: 'secret',
                        password_confirmation: 'secret'}
  end

  test "is valid proper attributes" do
    user = User.new(@user_attributes)
    assert user.valid?
  end

  test "is not valid without password" do
    user = User.new(@user_attributes.except(:password))
    assert !user.valid?, "User was valid without a password"
  end

  test "is not valid without password_confirmation" do
    user = User.new(@user_attributes.except(:password_confirmation))
    assert !user.valid?, "User was valid without a password_confirmation"
  end

  test "is not valid with different password and confirmation" do
    user = User.new(@user_attributes.merge(password: 'wrong'))
    assert !user.valid?, "User was valid with differing password and confirmation"
  end

  test "is not valid without nickname" do
    user = User.new(@user_attributes.except(:nickname))
    assert !user.valid?, "User was valid without a nickname"
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
