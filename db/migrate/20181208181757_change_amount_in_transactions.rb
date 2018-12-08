class ChangeAmountInTransactions < ActiveRecord::Migration[5.2]
  def change
    change_column :transactions, :amount, :numeric
  end
end
