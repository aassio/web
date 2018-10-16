class AddUtilityBillToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :has_utility_bill, :boolean, default: false
  end
end
