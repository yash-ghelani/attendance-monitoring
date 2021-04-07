#  The Lecturer controller will control
#  the actions shared between lecturers and admins

class LecturerController < ApplicationController
  #Authorise without needing a model
  authorize_resource :class => LecturerController

  #Show the Dashboard for Lecturer
  def home
    @sessions = SessionRegisteredLecturer.includes(:timetabled_session, :user).where(user: current_user)
    render :dashboard
  end

  def upcoming 
  end

  def previous
  end

end
