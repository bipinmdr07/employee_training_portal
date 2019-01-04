class TrainingeventController < ApplicationController
  include TrainingeventHelper
  require 'date'
  before_action :authenticate_user, :only => [:new, :create]
  
  def new
    @trainingevent = Trainingevent.new
  end

  def create
	@trainingevent = Trainingevent.new(trainingevent_params)
	
	attendee_ids = @trainingevent.employeeid.to_a
	attendee_ids = attendee_ids.delete_if { |x| x.empty? }
	
	eventdate = params[:trainingevent][:eventdatetime]
	eventdate = Date.strptime(eventdate, "%m/%d/%Y").to_datetime.strftime("%Y%m%d")
	coursename = Courseversion.find_by(:courseversionid=>@trainingevent.courseversionid).course.name
	filename = coursename + "_Signinsheet_" + eventdate + File.extname(params[:trainingevent][:signupsheet].original_filename)
	
	begin
	  uploader = SignupsheetUploader.new
	  file = params[:trainingevent][:signupsheet]
	  file.original_filename = filename
      uploader.store!(file)
	  
	  @trainingevent.signupsheet = filename
	  @trainingevent.eventdatetime = Date.strptime(params[:trainingevent][:eventdatetime], "%m/%d/%Y").to_datetime.strftime("%Y-%m-%d")
	  @trainingevent.save!
	  
	  attendee_ids.each do |attendeeid|
        @eventattendee = Eventattendee.new
        @eventattendee.trainingevent_id = @trainingevent.trainingeventid
        @eventattendee.employee_id = attendeeid
        @eventattendee.save!
	  end
	  flash[:notice] = "New training event added successfully"
      flash[:color]= "valid"
	rescue
	  trainigneventid = @trainingevent.trainingeventid
	  Eventattendee.where(trainingevent_id: trainigneventid).destroy_all
	  Trainingevent.where(trainingeventid: trainigneventid).destroy_all
	  flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
	end
    redirect_to(:controller => 'login', :action => 'login')
  end
  
  def getemployeelist
	courseid = Courseversion.select("course_id").where(:courseversionid=>params[:cvid])
	roleid = Coursesforrole.select("role_id").where(:course_id=>courseid)
	@employeelist = Employeerole.where(:role_id=>roleid).collect{|er| [ er.employee.firstname+ " " + er.employee.lastname, er.employee.employeeid  ] }
	respond_to do |format|
      format.json  { render :json => @employeelist }      
    end
  end
  
  private
  def trainingevent_params
    params.require(:trainingevent).permit(:trainingeventname, :courseversionid, :eventdatetime, :signupsheet, :employeeid=>[])
  end
end
