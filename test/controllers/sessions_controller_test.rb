require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "log in should succeed with good credentials" do
    post :create,
      email: accounts(:david).email,
      password: 'secret'

    assert_logged_in_as users(:david)
    assert_redirected_to messages_url
  end

  test "log in should fail with bad credentials" do
    post :create,
      email: 'nobody@example.com',
      password: 'foobar'

    assert_logged_out
    assert flash[:error]
    assert_response :success
  end

  test "log out should log the user out" do
    login users(:david)

    assert_logged_in_as users(:david)

    delete :destroy

    assert_logged_out
  end
end
