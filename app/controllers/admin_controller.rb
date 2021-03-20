#  The Admin Controller will manage actions belonging to
#  just admins, but also inhreit all actions from lecturers

class AdminController < LecturerController
  #Authorise without needing a model
  authorize_resource :class => AdminController

  #TODO there is currently a bug where lecturers can access all admin methods
	def home
		super
	end
end
