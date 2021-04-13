#  The Lecturer controller will control
#  the actions shared between lecturers and admins

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

    @week = params[:week] || "0"
    @week = @week.length < 4 ? @week.to_i : 0
    @week_start = Time.now.utc.beginning_of_week+@week.week
    @week_end = Time.now.utc.end_of_week+@week.week
    
    @sessions = @sessions.where(session_registered_lecturers: {user: current_user}, start_time: @week_start..@week_end)
    @sessions = @sessions.order(created_at: :asc)
    render :dashboard
  end

  def upcoming 
  end

  def previous
  end

end
