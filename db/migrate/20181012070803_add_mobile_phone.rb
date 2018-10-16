class AddMobilePhone < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mobile_phone, :string
    add_column :users, :mobile_phone_confirmed_at, :datetime
  end
end
