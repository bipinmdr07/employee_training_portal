class ApplicationuserController < ApplicationController
  #before_action :save_login_state, :only => [:new, :create]
  before_action :authenticate_user, :only => [:new, :create]
  def new
    @userrole = Applicationuserinrole.new
  end
  
  def create
    @userrole = Applicationuserinrole.new
	@userrole.applicationuser = Applicationuser.new(user_params)
	role_id = @userrole.applicationuser.role_id
	@userrole.applicationuser.save
	@userrole.applicationuser_id = Applicationuser.find_by(:email=> @userrole.applicationuser.email).applicationuserid
	@userrole.applicationrole_id = role_id
    if @userrole.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
	  Applicationuser.destroy(@userrole.applicationuser_id)
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    redirect_to(:controller => 'login', :action => 'login')
  end
  
  private
  def user_params
    params.require(:applicationuser).permit(:firstname, :lastname, :email, :password, :password_confirmation, :role_id)
  end
end
