class OrderMailer < ApplicationMailer

  def new_order_email
    @order = params[:order]

    mail to: params[:user].email
  end
end
