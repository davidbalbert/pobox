class PagesController < ApplicationController
  before_filter :require_logout
end
