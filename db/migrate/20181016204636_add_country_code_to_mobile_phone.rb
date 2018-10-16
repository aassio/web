class AddCountryCodeToMobilePhone < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mobile_phone_country_code, :integer
    add_column :verification_sms, :mobile_phone_country_code, :integer
  end
end
