class OrderPlaceJob < ApplicationJob
  queue_as :default

  def perform(order, user)
    OrderMailer.new_order_email(order, user).deliver
  end

end
