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
      redirect_to :controller => 'lecturer', :action => 'home'
    else
      redirect_to :controller => 'student', :action => 'home'
    end
  end

  #DEVELOPMENT ONLY (set current user to a student) TODO devOnly
  def set_student
    @user = User.find(current_user.id)
    @user.admin=false
    @user.lecturer=false
    @user.save
    redirect_to "/", notice: "You have been updated to a student"
  end

  #DEVELOPMENT ONLY (set current user to a admin) TODO devOnly
  def set_admin
    @user = User.find(current_user.id)
    @user.admin=true
    @user.lecturer=false
    @user.save
    redirect_to "/", notice: "You have been updated to an admin"
  end

  #DEVELOPMENT ONLY (set current user to a lecturer) TODO devOnly
  def set_lecturer
    @user = User.find(current_user.id)
    @user.admin=false
    @user.lecturer=true
    @user.save
    redirect_to "/", notice: "You have been updated to a lecturer"
  end



end
