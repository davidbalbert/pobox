class Registration
  include ActiveModel::Model

  attr_accessor :nickname, :email, :password, :password_confirmation

  def submit
    user.nickname = nickname
    user.password = password
    user.password_confirmation = password_confirmation

    account.email = email

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
