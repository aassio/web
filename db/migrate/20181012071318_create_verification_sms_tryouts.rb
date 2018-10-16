class CreateVerificationSmsTryouts < ActiveRecord::Migration[5.2]
  def change
    create_table :verification_sms_tryouts do |t|
      t.integer :user_id
      t.string :code
      t.timestamps
    end
  end
end
