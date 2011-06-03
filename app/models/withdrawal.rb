class Withdrawal < ActiveRecord::Base
  belongs_to :account
  validates_numericality_of :amount, :greater_than => 0
end
