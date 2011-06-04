require 'user_admin'

class SessionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user
      if user.valid_pin?(params[:pin])
        session[:user_id] = user.id
        redirect_to root_url and return
      elsif user.locked_out?
        flash.now[:error] = "User is locked out due to too many login attempts"
      else
        remaining_logins = user.remaining_logins
        flash.now[:error] = "Invalid PIN, you have #{pluralize remaining_logins, 'attempt'} left"
      end
    else
      flash.now[:error] = "Name not found"
    end
    render :new
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
