class CreateVerificationEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :verification_events do |t|
      t.integer :admin_user_id
      t.string :what_happened
      t.integer :user_id
      t.timestamps
    end
  end
end
