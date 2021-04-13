#  The Admin Controller will manage actions belonging to
#  just admins, but also inhreit all actions from lecturers

class AdminController < LecturerController
  #Authorise without needing a model
  authorize_resource :class => false

  #Call the home method for lecturers
  def home
    @week = params[:week].to_i || 0
    @week_start = Time.now.utc.beginning_of_week+@week.week
    @week_end = Time.now.utc.end_of_week+@week.week
    
    @sessions = TimetabledSession.all.where(start_time: @week_start..@week_end)
    @count = @sessions.size
    @sessions = @sessions.order(created_at: :asc)
    render :dashboard
  end
end
