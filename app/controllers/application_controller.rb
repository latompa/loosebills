class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user  

  private  
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end  

  def require_user
    unless current_user
      flash[:notice] = "You must be logged in"
      redirect_to new_session_url
      return false
    end
  end

end
