require 'test_helper'

class RegistrationAndSessionsTest < ActionDispatch::IntegrationTest
  test "log in and log out" do
    get '/login'
    assert_response :success

    post_via_redirect '/sessions',
      email: accounts(:david).email,
      password: 'secret'
    assert_response :success
    assert_equal '/messages', path
    assert_logged_in_as users(:david)

    get_via_redirect '/logout'
    assert_response :success
    assert_equal '/', path
    assert_logged_out
  end

  test "registration" do
    get '/signup'
    assert_response :success

    post_via_redirect '/registrations',
      registration: {
        nickname: 'Nick',
        email: 'nick@example.com',
        password: 'secret',
        password_confirmation: 'secret'}
    assert_response :success
    assert_equal '/messages', path
    assert_logged_in

    get_via_redirect '/logout'
    get '/login'
    assert_response :success

    post_via_redirect '/sessions',
      email: 'nick@example.com',
      password: 'secret'
    assert_response :success
    assert_logged_in
  end
end
