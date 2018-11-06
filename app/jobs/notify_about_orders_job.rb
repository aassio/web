class NotifyAboutOrdersJob < ApplicationJob
  queue_as :default

  def perform(order)
    message = "New order https://aass.io/admin/orders/#{order.id}\nAmount: #{order.purchase_price} ETH"
    HTTParty.get "http://crierbot.appspot.com/#{Rails.application.credentials.crier_bot_token}/send", query: {message: message}
  end
end
