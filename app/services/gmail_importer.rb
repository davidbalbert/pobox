class GmailImporter
  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def import(number_of_messages)
    @imap = Net::IMAP::Gmail.new('imap.gmail.com', ssl: true)
    @imap.login(email, password)
    @imap.examine(folder)

    fetch(number_of_messages)

    each_message do |message, labels|
      puts message
    end
  end

  private
  def fetch(number_of_messages)
    exists = @imap.responses["EXISTS"].first
    message_range = (exists - number_of_messages)..exists
    columns = ["UID", "FLAGS", "X-GM-LABELS", "BODY.PEEK[]"]

    @messages = @imap.fetch(message_range, columns).map do |data|
      [data.attr["BODY[]"], data.attr["X-GM_LABELS"]]
    end
  end

  def each_message(&block)
    @messages.each(&block)
  end

  def folder
    @folder ||= @imap.list("", "*").find {|x| x.attr.include? :All}.name
  end
end
