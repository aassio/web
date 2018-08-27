class EmailSubscription < ApplicationRecord
  validates :email, :name, presence: true
end
