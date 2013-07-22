ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_logged_in_as(user)
    assert_equal user.id, session[:user_id], "#{user.nickname} with id #{user.id} was not logged in"
  end

  def assert_logged_in
    assert session[:user_id], "There was no user logged in"
  end

  def assert_logged_out
    assert_nil session[:user_id], "A user was logged in"
  end
end

require 'mocha/setup'
