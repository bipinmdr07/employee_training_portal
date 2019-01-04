module CourseHelper
  def option_for_courseroles
    Role.all.collect {|r| [ r.rolename, r.rolesid  ] }
  end
  
  def option_for_courses
    Course.all.collect {|r| [ r.name, r.courseid  ] }
  end
end
