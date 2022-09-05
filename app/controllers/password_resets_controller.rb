class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_later
     end
    redirect_to root_path, notice: "Password Reset link sent!"
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
  end
end
