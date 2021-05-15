
# The Lecturer controller, manages all the actions
# for the lecturer users, the main actions are...
# - Rendering the dashboard

class LecturerController < ApplicationController

  #Authorise without needing a model
  authorize_resource :class => LecturerController

  #Show the Dashboard for Lecturer
  def home
    #Prevent admins from viewing dashboards as a lecturer
    if(current_user.admin)
      return redirect_to :controller => 'admin', :action => 'home'
    end

    @sessions = TimetabledSession.joins(:session_registered_lecturers => :user)

    @current_week = Time.now.utc.beginning_of_week
    begin
      @week_start = (params[:start_date] || "").to_datetime || @current_week
    rescue ArgumentError => e
      @week_start = @current_week
    end
    @week_start = @week_start.beginning_of_week
    @week_end = @week_start.end_of_week
    
    @sessions = @sessions.where(session_registered_lecturers: {user: current_user}, start_time: @week_start..@week_end)
    @sessions = @sessions.order(created_at: :asc)
    render :dashboard
  end

end
