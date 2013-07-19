class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login(user)
    reset_session
    session[:user_id] = user.id
  end

  def logout
    reset_session
    redirect_to root_url
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def require_login
    redirect_to login_path, notice: "You need to be logged in for that" unless current_user
  end

  def require_logout
    redirect_to messages_url if current_user
  end
end
