class CreateVerificationSms < ActiveRecord::Migration[5.2]
  def change
    create_table :verification_sms do |t|
      t.integer :user_id
      t.string :code
      t.string :phone
      t.timestamps
    end
  end
end
