#  The Admin Controller will manage actions belonging to
#  just admins, but also inhreit all actions from lecturers

class AdminController < LecturerController
  #Authorise without needing a model
  authorize_resource :class => false

  #Call the home method for lecturers
	def home
    @sessions = TimetabledSession.includes(:session_registered_lecturers, :user).all
    render :dashboard
	end
end
