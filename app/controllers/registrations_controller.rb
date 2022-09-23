class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Signed In"
      # SignupMailer.with(user: @user).new_user_registration_email.deliver_later
      SignupJob.perform_later(user: @user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :mobile)
  end
end
