class WithdrawalsController < ApplicationController
  before_filter :require_user
  before_filter :load_account
  
  def create
    @withdrawal = @account.withdrawals.create :amount => params[:amount]
    if @withdrawal.persisted?
      redirect_to @withdrawal
    else
      flash[:error] = @withdrawal.errors.full_messages.join(", ")
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
