class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :amount
      t.numeric :purchase_price
      t.string :purchase_currency
      t.string :aasm_state
      t.timestamps
    end
  end
end
