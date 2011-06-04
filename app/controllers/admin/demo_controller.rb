require 'user_admin'
class Admin::DemoController < ApplicationController
  
  def reset_users
    Loosebills::UserAdmin.reset_users
    flash[:notice] = "Users were reset"
    redirect_to new_session_path
  end
    
  def restock_bills
    Bill.update_all('units = 100')
    flash[:notice] = "100 bills of each denomination were restocked"
    redirect_to new_session_path
  end
  
end