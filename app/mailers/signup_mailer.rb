class SignupMailer < ApplicationMailer

  def new_user_registration_email
    @user = params[:user]

    mail to: params[:user].email
  end
end
