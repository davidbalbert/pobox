class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])

    if @registration.submit
      flash[:success] = "Account created!"
      redirect_to root_url
    else
      flash.now[:error] = "There was a problem creating your account"
      render :new
    end
  end
end
