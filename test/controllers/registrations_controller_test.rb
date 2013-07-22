require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "create account and log in" do
    assert_difference('User.count') do
      post :create,
        registration: {
          nickname: 'Nick',
          email: 'nick@example.com',
          password: 'secret',
          password_confirmation: 'secret'}
    end

    assert_redirected_to messages_url
    assert flash[:success]
    assert_logged_in
  end

  test "should fail to create account without required info" do
    assert_no_difference('User.count') do
      post :create
    end

    assert flash[:error]
    assert_logged_out
  end
end
