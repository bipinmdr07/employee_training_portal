class ApplicationuserinroleController < ApplicationController
  before_action :authenticate_user, :only => [:create, :new]
  
  def new
    @applicationuserinrole = Applicationuserinrole.new
  end

  def create
    @applicationuserinrole = Applicationuserinrole.new(applicationuserrole_params)
	if(Applicationuser.get_id(@applicationuserinrole.email))
	  @applicationuserinrole.applicationuser_id = Applicationuser.get_id(@applicationuserinrole.email)
	  @applicationuserinrole.applicationrole_id = @applicationuserinrole.role_id
      if @applicationuserinrole.save
        flash[:notice] = "Role successfully set"
        flash[:color]= "valid"
      else
        flash[:notice] = "Role not assigned"
        flash[:color]= "invalid"
	  end
	else
	  flash[:notice] = "User not found"
      flash[:color]= "invalid"
    end
	redirect_to(:controller => 'applicationuserinrole', :action => 'new')
  end
  
  private
  def applicationuserrole_params
    params.require(:userinrole).permit(:email, :role_id)
  end
end
