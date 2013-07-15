class Registration < Form
  wraps user: [:nickname, :password, :password_confirmation]
  wraps account: [:email]

  def user
    @user ||= User.new
  end

  def account
    @account ||= user.accounts.build
  end
end
