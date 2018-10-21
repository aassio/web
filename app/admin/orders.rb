ActiveAdmin.register Order do

  permit_params :amount, :user_id, :comment

  action_item 'Process', only: :show do
    if order.draft?
      link_to 'Process', process_order_admin_order_path(order)
    end
  end

  member_action :process_order do
    order = Order.find params[:id]
    if order.draft?
      raise 'Incorrect order currency' if order.purchase_currency != 'ETH'
      amount = PreSaleTokenPrice.new.aas_tokens_for_eth Date.current, order.purchase_price
      order.update amount: amount
      order.process!
      order.user.transactions.create! amount: amount, comment: "Standard token purchase order ##{order.id}"
    end
    redirect_to admin_order_path(order), notice: 'Order processed'
  end


end
