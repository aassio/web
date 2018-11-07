class FinancialMailer < ApplicationMailer

  def new_order(order)
    @order = order
    mail(to: 'rf@aass.io', cc: %w(mk@aass.io sg@aass.io), subject: "New order ##{order.id} in aassio PreSale")
  end

end
