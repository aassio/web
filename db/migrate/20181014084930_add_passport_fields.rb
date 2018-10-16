class AddPassportFields < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :has_passport_front_page, :boolean, default: false
    add_column :users, :has_passport_back_page, :boolean, default: false
    add_column :users, :has_passport_selfie, :boolean, default: false
  end
end
