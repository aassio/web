class AddTosAgreementToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tos_agreement, :boolean, default: false
  end
end
