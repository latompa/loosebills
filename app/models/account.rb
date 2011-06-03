class Account < ActiveRecord::Base
  belongs_to :user
  has_many :withdrawals
  
  def withdraw(amount)
    raise "insufficient funds" unless sufficient_funds?(amount)
    withdrawal = self.withdrawals.create! :amount => amount.to_i
    self.balance -= amount.to_i
    save
    withdrawal
  end
  
  def sufficient_funds?(amount)
    self.balance - amount.to_i >= 0
  end
end
