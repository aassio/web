class AddTosToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :tos_agreement, :boolean, default: false
  end
end
