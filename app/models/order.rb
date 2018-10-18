class Order < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 50000 }

  include AASM

  aasm do
    state :draft, initial: true
    state :processed
    state :cancelled
    event :process do
      transitions from: :draft, to: :processed
    end
    event :cancel do
      transitions from: :draft, to: :cancelled
    end
  end

end
