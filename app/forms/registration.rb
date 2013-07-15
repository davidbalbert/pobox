class Registration
  include ActiveModel::Model

  delegate *[:nickname, :password, :password_confirmation].map {|a| [a, :"#{a}="]}.flatten, to: :user
  delegate :email, :email=, to: :account

  def submit
    if valid?
      user.save
      account.save
      true
    else
      false
    end
  end

  def user
    @user ||= User.new
  end

  def account
    @account ||= user.accounts.build
  end

  def valid?(context = nil)
    valid = user.valid?(context) && account.valid?(context)
    populate_errors

    valid
  end

  private
  def populate_errors
    user.errors.each do |attribute, error|
      errors.add(attribute, error)
    end

    account.errors.each do |attribute, error|
      errors.add(attribute, error)
    end
  end
end
