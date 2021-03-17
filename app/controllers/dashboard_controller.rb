# The Dashboard Controller handles rendering the dashboards
# for each user of the application, if the current_user is an
# admin or lecturer, the "admin" view will be rendered, by
# default the student view will be rendered, these views are located
# in views/dashboard

class DashboardController < ApplicationController

  def index
      #Update the navbar label
      @current_nav_identifier = :home

      #Is this user an admin or lecturer?
      if(current_user.admin || current_user.lecturer)
        render :admin
      end
      #Render Index (student) by default
      
    end

end
