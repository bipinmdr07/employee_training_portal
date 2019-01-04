class ApplicationController < ActionController::Base
  protected 
  def authenticate_user
    if session[:user_id]
       # set current user object to @current_user object variable
      @current_user = Applicationuser.find session[:user_id] 
      return true	
    else
      redirect_to(:controller => 'login', :action => 'login')
      return false
    end
  end
  
  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'login', :action => 'home')
      return false
    else
      return true
    end
  end
end
