#  The student controller manages the actions
#  for students

class StudentController < ApplicationController

  #Show the Dashboard
  def home
    if(!current_user.admin && !current_user.lecturer)
      #Render the student dashboard
      render :dashboard
    else
      #If this user is not student go to root
      redirect_to :root
    end
  end

end
