#  The student controller manages the actions
#  for students

class StudentController < ApplicationController
  #Authorise without needing a model
  authorize_resource :class => StudentController

  #Show the Dashboard
  def home
    render :dashboard
  end

end
