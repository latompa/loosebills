class Withdrawal < ActiveRecord::Base
  belongs_to :account
  validates_numericality_of :amount, :greater_than => 0
  validate :sufficient_account_funds
  before_save :update_account_balance
  before_save :dispense_bills
  
  serialize :bills
  
  def sufficient_account_funds
    unless account && account.sufficient_funds?(amount)
      errors[:base] << "Not enough funds on account"
    end
  end
    
  def update_account_balance
    account.balance -= amount.to_i
    account.save
  end
  
  def dispense_bills
    wad = Atm.dispense(amount)
    if wad.present?
      self.bills = wad
    else
      errors[:base] << "No bills available"
      false
    end
  end
end
