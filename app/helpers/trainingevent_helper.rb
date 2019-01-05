module TrainingeventHelper
  def option_for_employeeroles
    Employee.all.collect {|e| [ e.firstname+ " " + e.lastname, e.employeeid  ] }
  end

  def option_for_courseversion
    Courseversion.all.collect {|cv| [ cv.course.name + " version:" + cv.version.versionname, cv.courseversionid  ] }
  end
end
