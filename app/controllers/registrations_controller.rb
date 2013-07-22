class RegistrationsController < ApplicationController
  before_filter :require_logout
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])

    if @registration.submit
      login @registration.user
      flash[:success] = "Account created!"
      redirect_to messages_url
    else
      flash.now[:error] = "There was a problem creating your account"
      render :new
    end
  end
end
