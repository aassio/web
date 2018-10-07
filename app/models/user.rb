class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :transactions

  validates_acceptance_of :tos_agreement, allow_nil: false, accept: true, on: :create

  # Returns displayable balance. We store balance in integer, AAS token has 6 digits after period
  # @return Decimal
  def actual_balance
    balance
  end

  def to_s
    email
  end

end
