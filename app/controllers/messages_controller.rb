class MessagesController < ApplicationController
  before_filter :require_login

  def index
    @messages = Message.all
  end
end
