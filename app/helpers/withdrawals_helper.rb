module WithdrawalsHelper
  
  def sufficient_funds?(amount)
    current_user.account.sufficient_funds?(amount)
  end
end
