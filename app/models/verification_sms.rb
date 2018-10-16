class VerificationSms < ApplicationRecord
  validates :code, :phone, :mobile_phone_country_code, :user_id, presence: true
  belongs_to :user

  after_create :send_sms
  after_initialize :generate_code

  private

  def send_sms
    Rails.logger.info code
    Authy::PhoneVerification.start via: "sms", country_code: self.mobile_phone_country_code, phone_number: self.phone
  end

  def generate_code
    self.code = 4.times.map { rand(9) }.join
  end


end
