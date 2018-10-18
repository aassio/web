class OrdersController < BackofficeDefaultController

  def create
    @order = current_user.orders.new params[:order].permit(:amount)
    if @order.amount.is_a?(Numeric) && @order.amount > current_user.max_purchase_in_aas
      @order.amount = current_user.max_purchase_in_aas
    end
    if @order.save
      redirect_to account_path, notice: 'Order created, we will contact you shortly'
    else
      redirect_to account_path, alert: 'Order wasn`t created'
    end
  end

end



