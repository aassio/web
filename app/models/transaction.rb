class Transaction < ApplicationRecord
  belongs_to :user
  validates :comment, presence: true
  after_create :update_user_balance


  private

  def update_user_balance
    user.update balance: user.transactions.sum(&:amount)
  end

end
