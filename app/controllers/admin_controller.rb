#  The Admin Controller will manage actions belonging to
#  just admins, but also inhreit all actions from lecturers

class AdminController < LecturerController

	def home
		super
	end
end
