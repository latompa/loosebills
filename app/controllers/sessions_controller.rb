class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user
      if user.valid_pin?(params[:pin])
        session[:user_id] = user.id
        redirect_to root_url and return
      else
        flash.now[:error] = "Invalid PIN"
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
