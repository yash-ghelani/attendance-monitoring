#  The Admin Controller will manage actions belonging to
#  just admins, but also inhreit all actions from lecturers

class AdminController < LecturerController
  #Authorise without needing a model
  authorize_resource :class => false

  #Call the home method for lecturers
  def home
    @current_week = Time.now.utc.beginning_of_week
    begin
      @week_start = (params[:start_date] || "").to_datetime || @current_week
    rescue ArgumentError => e
      @week_start = @current_week
    end
    @week_start = @week_start.beginning_of_week
    @week_end = @week_start.end_of_week

    @sessions = TimetabledSession.all.where(start_time: @week_start..@week_end)
    @sessions = @sessions.order(created_at: :asc)
    render :dashboard
  end
end
