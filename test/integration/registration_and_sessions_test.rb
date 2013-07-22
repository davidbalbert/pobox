require 'test_helper'

class RegistrationAndSessionsTest < ActionDispatch::IntegrationTest
  test "log in and log out" do
    get '/login'
    assert_response :success

    post_via_redirect '/sessions', email: accounts(:david).email, password: 'secret'
    assert_response :success
    assert_equal '/messages', path
    assert_logged_in(users(:david))

    get_via_redirect '/logout'
    assert_response :success
    assert_equal '/', path
    assert_logged_out
  end
end
