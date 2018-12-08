class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :transactions
  has_many :verification_events
  has_many :verification_smses, class_name: 'VerificationSms'
  has_many :verification_sms_tryouts
  has_many :orders

  scope :for_level_2, -> { where(verification_level: 1).where('mobile_phone_confirmed_at IS NOT NULL') }
  scope :for_level_3, -> { where(verification_level: 2).where(has_passport_front_page: true).where(has_passport_back_page: true).where(has_passport_selfie: true) }
  scope :for_level_4, -> { where(verification_level: 3).where(has_utility_bill: true) }
  scope :for_level_5, -> { where(verification_level: 4).where(sent_interview_request: true) }
  scope :level_1, -> { where(verification_level: 1) }
  scope :level_2, -> { where(verification_level: 2) }
  scope :level_3, -> { where(verification_level: 3) }
  scope :level_4, -> { where(verification_level: 4) }
  scope :level_5, -> { where(verification_level: 5) }

  validates_acceptance_of :tos_agreement, allow_nil: false, accept: true, on: :create
  validates :first_name, :last_name, presence: true
  validates :verification_level, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :mobile_phone, format: { with: /\d{6,}/, message: 'Wrong format of phone number' }, allow_blank: true
  validates :mobile_phone_country_code, format: { with: /\d{1,}/, message: 'Wrong format of phone number country code' }, allow_blank: true

  has_one_attached :passport_front_page
  has_one_attached :passport_back_page
  has_one_attached :passport_selfie
  has_one_attached :utility_bill

  # Returns displayable balance. We store balance in integer, AAS token has 6 digits after period
  # @return Decimal
  def actual_balance
    balance
  end

  def to_s
    email
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # @return Boolean
  def mobile_phone_confirmed?
    !mobile_phone.nil? && !mobile_phone_country_code.nil? && !mobile_phone_confirmed_at.nil?
  end

  def phone
    "+#{mobile_phone_country_code}#{mobile_phone}"
  end


  # After email confirm give welcome bonus
  def confirm
    if super
      self.transactions.create amount: 36, comment: 'Email verification bonus'
      self.verification_events.create what_happened: 'User confirmed email'
      self.update verification_level: 1
    end
  end

  def ready_for_level?(level)
    case level
    when 2 then
      return mobile_phone_confirmed? && verification_level == 1
    when 3 then
      return verification_level == 2 && has_passport_front_page? && has_passport_back_page? && has_passport_selfie?
    when 4 then
      return verification_level == 3 && has_utility_bill?
    when 5 then
      return verification_level == 4 && sent_interview_request?
    end
    false
  end

  def max_purchase_in_usd
    case verification_level
    when 0 then 0
    when 1 then 250
    when 2 then 500
    when 3 then 1000
    when 4 then 1500
    when 5 then 5000
    end
  end

  def max_purchase_in_eth
    max_purchase_in_usd / 200.0
  end

  def max_purchase_in_aas
    (max_purchase_in_usd / 0.1).round(2)
  end





end
