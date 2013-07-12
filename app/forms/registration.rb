class Registration
  include ActiveModel::Model

  attr_accessor :nickname, :email, :password, :password_confirmation

  def submit
    user.nickname = nickname
    user.password = password
    user.password_confirmation = password_confirmation

    account.email = email

    if user.valid? && account.valid?
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
end
