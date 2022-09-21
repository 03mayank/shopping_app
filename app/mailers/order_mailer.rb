class OrderMailer < ApplicationMailer

  def new_order_email(order, user)
    @order = order

    mail(to: user.email,
      subject: 'New Order Placed')
  end
end
