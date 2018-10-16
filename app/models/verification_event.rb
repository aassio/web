# This model stores level changes history:
# Who changed
# Which events happened (like call happened or passport/ID uploaded)
class VerificationEvent < ApplicationRecord
  validates :user_id, :what_happened, presence: true
end
