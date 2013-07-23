class ImportsController < ApplicationController
  def create
    importer = GmailImporter.new(params[:email], params[:password])

    importer.delay.import(50)

    flash[:success] = "Importing your mail now"
    redirect_to root_url
  end
end
