class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
   
    def confirmation_email(order)
      @order = order
      mail(to: @order.email, subject: "Order #" + @order.id.to_s + " - thanks for ordering!")
    end
  end