class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: @user.email, subject: "Account Activation For The Raven Circle"
  end

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Reset Password For The Raven Circle"
  end
end
