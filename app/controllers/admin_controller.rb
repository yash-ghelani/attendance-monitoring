#  The Admin Controller will manage actions belonging to
#  just admins, but also inhreit all actions from lecturers

class AdminController < LecturerController
  #Authorise without needing a model
  authorize_resource :class => false

  #Call the home method for lecturers
	def home
    @sessions = TimetabledSession.includes(:session_registered_lecturers, :user).all
    @count = @sessions.size
    @limit = 1
    @offset = params[:offset].to_i || 0
    @sessions = @sessions.order(start_time: :desc).offset(params[:offset] || 0).limit(@limit)
    @page = @offset*@limit
    render :dashboard
	end
end
