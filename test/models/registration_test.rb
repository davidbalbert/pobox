require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  test "it is valid when user and account are valid" do
    registration = Registration.new(
      nickname: 'dave',
      email: 'dave@example.com',
      password: 'secret',
      password_confirmation: 'secret'
    )

    assert registration.valid?
  end

  test "it is invalid when user is invalid" do
    registration = Registration.new(
      nickname: 'dave',
      email: 'dave@example.com',
      password: 'secret',
    )

    assert !registration.valid?
    assert !registration.user.valid?
  end

  test "it is invalid when account is invalid" do
    registration = Registration.new(
      nickname: 'dave',
      password: 'secret',
      password_confirmation: 'secret'
    )

    assert !registration.valid?
    assert !registration.account.valid?
  end
end
