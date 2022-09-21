class SignupMailer < ApplicationMailer

  def new_user_registration_email(user)
    @user = user[:user]

    mail(to: user[:user].email,
      subject: 'Welcome to Shopping zone Site')
  end
end
