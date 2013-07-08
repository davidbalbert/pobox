class GmailImporter
  attr_reader :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  def import(number_of_messages)
    puts "Importing the first #{number_of_messages} emails from Gmail"
  end
end
