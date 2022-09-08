class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t(".mailers_subject")
  end
end
