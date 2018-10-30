class AddWalledIdToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :source_wallet, :string
  end
end
