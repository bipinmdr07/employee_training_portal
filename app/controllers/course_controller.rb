class CourseController < ApplicationController
  before_action :authenticate_user, :only => [:new, :create]

  def new
    @courseversion = Courseversion.new
  end

  def create
    begin
      @courseversion = Courseversion.new
      @courseversion.course = Course.new(course_params)

      courserole_ids = @courseversion.course.emp_role_id.to_a
      courserole_ids = courserole_ids.delete_if { |x| x.empty? }
      versionname = @courseversion.course.versionname

      @courseversion.course.save!

      @courseversion.version = Version.new
      @courseversion.version.versionname = versionname
      @courseversion.version.save!

      @courseversion.course_id = @courseversion.course.courseid
      @courseversion.version_id = @courseversion.version.versionid
      @courseversion.save!

      courserole_ids.each do |courseroleid|
        @courserole = Coursesforrole.new
      @courserole.course_id = @courseversion.course.courseid
        @courserole.role_id = courseroleid
      @courserole.save!
      end

      flash[:notice] = "New course added successfully"
        flash[:color]= "valid"

    rescue
        Courseversion.destroy(@courseversion.courseversionid)
        Course.destroy(@courseversion.course.courseid)
        Version.destroy(@courseversion.version.versionid)
          flash[:notice] = "Form is invalid"
          flash[:color]= "invalid"
    end
    redirect_to(:controller => 'login', :action => 'login')
  end

  private
  def course_params
    params.require(:course).permit(:name, :description, :versionname, :emp_role_id=>[])
  end
end
