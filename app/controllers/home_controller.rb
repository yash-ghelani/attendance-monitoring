#  The Home controller will manage the homescreen for the
#  application, it will check the current user and redirect
#  them to the appropriate controller

class HomeController < ApplicationController

  def index
    #Update the navbar label
    @current_nav_identifier = :home

    #Redirect to appropriate controllers
    if(current_user.admin)
      redirect_to :controller => 'admin', :action => 'home'
    elsif (current_user.lecturer)
      redirect_to :controller => 'lecturer', :action => 'upcoming'
    else
      redirect_to :controller => 'student', :action => 'code'
    end
  end

end
