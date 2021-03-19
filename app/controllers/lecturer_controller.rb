#  The Lecturer controller will control
#  the actions shared between lecturers and admins

class LecturerController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  #Show the Dashboard
  def home
    if(current_user.admin || current_user.lecturer)
      #Render the Lecturer/Admin dashboard
      render :dashboard
    else
      #If this user is not admin or lecturer go to root
      redirect_to :root
    end
  end

end
