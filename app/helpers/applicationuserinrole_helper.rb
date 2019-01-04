module ApplicationuserinroleHelper
  def option_for_userroles
    Applicationrole.all.collect {|r| [ r.applicationrolename, r.applicationroleid ] }
  end
end
