class SignupJob < ApplicationJob
  queue_as :default

  def perform(user)
    SignupMailer.new_user_registration_email(user).deliver
  end
end
