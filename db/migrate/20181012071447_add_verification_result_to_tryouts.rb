class AddVerificationResultToTryouts < ActiveRecord::Migration[5.2]
  def change
    add_column :verification_sms_tryouts, :result, :boolean
  end
end
