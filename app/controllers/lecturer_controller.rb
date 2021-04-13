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
    
    @sessions = TimetabledSession.joins(:session_registered_lecturers => :user).where(session_registered_lecturers: {user: current_user})
    @count = @sessions.size
    @limit = 1
    @offset = params[:offset].to_i || 0
    @sessions = @sessions.order(created_at: :desc).offset(@offset).limit(@limit)
    @page = @offset*@limit
    render :dashboard
  end

  def upcoming 
  end

  def previous
  end

end
