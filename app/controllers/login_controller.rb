class LoginController < ApplicationController
  before_action :authenticate_user, :only => [:home]
  before_action :save_login_state, :only => [:login, :login_attempt]

  def login_attempt
    authorized_user = Applicationuser.authenticate(params[:username],params[:login_password])
    if authorized_user
	  session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome, #{authorized_user.firstname} #{authorized_user.lastname}"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def home
  end

  def login
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end
