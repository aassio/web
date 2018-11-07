class OrdersController < BackofficeDefaultController

  def create
    @order = current_user.orders.new params[:order].permit(:purchase_price, :source_wallet, :tos_agreement)
    @order.purchase_currency = 'ETH'
    if @order.purchase_price.is_a?(Numeric) && @order.purchase_price > current_user.max_purchase_in_eth
      @order.purchase_price = current_user.max_purchase_in_eth
    end
    if @order.save
      FinancialMailer.new_order(@order).deliver_now
      redirect_to account_path, notice: 'Order created, follow instructions'
    else
      redirect_to account_path, alert: ("Order wasn`t created: " + @order.errors.map { |k,v| "#{k.to_s} #{v}" }.join(', ').to_s)
    end
  end



  def calculate_aas
    sum = params[:sum].to_f
    render plain: "#{PreSaleTokenPrice.new.aas_tokens_for_eth(Date.current, sum)} AAS tokens"
  end

end



