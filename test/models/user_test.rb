require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user_attributes = {nickname: 'dave',
                        password: 'secret',
                        password_confirmation: 'secret'}
  end

  test "should save with proper attributes" do
    user = User.new(@user_attributes)
    assert user.save
  end

  test "should not save without password" do
    user = User.new(@user_attributes.except(:password))
    assert !user.save
  end

  test "should not save without password_confirmation" do
    user = User.new(@user_attributes.except(:password_confirmation))
    assert !user.save
  end

  test "should not save with different password and confirmation" do
    user = User.new(@user_attributes.merge(password: 'wrong'))
    assert !user.save
  end

  test "should not save without nickname" do
    user = User.new(@user_attributes.except(:nickname))
    assert !user.save
  end
end
