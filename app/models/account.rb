class Account < ActiveRecord::Base
  belongs_to :user
  has_many :withdrawals

  def sufficient_funds?(amount)
    self.balance - amount.to_i >= 0
  end
end
