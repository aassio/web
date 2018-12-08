class ChangeAmountInOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :amount, :numeric
    change_column :users, :balance, :numeric
  end
end
