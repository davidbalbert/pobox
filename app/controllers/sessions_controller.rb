class SessionsController < ApplicationController
  before_filter :require_logout, except: :destroy
  before_filter :require_login, only: :destroy

  def create
    user = User.authenticate_by_email(params[:email], params[:password])

    if user
      login user
      redirect_to messages_url
    else
      flash.now[:error] = "Your email address or password was incorrect"
      render :new
    end
  end

  def destroy
    logout
  end
end
