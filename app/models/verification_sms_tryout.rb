# @deprecated if Twilio works
class VerificationSmsTryout < ApplicationRecord
  validates :user_id, :code, presence: true
  validates :code, length: {is: 4}
  belongs_to :user
end
