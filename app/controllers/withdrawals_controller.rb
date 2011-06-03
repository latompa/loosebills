class WithdrawalsController < ApplicationController
  before_filter :require_user
  before_filter :load_account
  
  def create
    @withdrawal = @account.withdraw params[:amount]
    if @withdrawal.save
      redirect_to @withdrawal
    else
      flash[:error] = @withdrawal.error.full_messages
      redirect_to root_path
    end
  end
  
  def show
    @withdrawal = @account.withdrawals.find params[:id]
  end
  
  def load_account
    @account = current_user.account
  end
end
