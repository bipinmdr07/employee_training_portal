class VersionController < ApplicationController
  before_action :authenticate_user, :only => [:new, :create]
  
  def new
    @courseversion = Courseversion.new
  end

  def create
    @courseversion = Courseversion.new
	@courseversion.version = Version.new(version_params)
	courseid = @courseversion.version.course_id
	@courseversion.version.save!
	
	@courseversion.course_id = courseid
	@courseversion.version_id = @courseversion.version.versionid
	
	if @courseversion.save
	  flash[:notice] = "New course added successfully"
      flash[:color]= "valid"
    else
	  Version.destroy(@courseversion.version.versionid)
	  flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
	end
	
    redirect_to(:controller => 'login', :action => 'login')
  end
  
  private
  def version_params
    params.require(:version).permit(:versionname, :course_id)
  end
end
