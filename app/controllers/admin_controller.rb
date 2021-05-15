
# The admin controller manages the actions performed
# by an admin, this includes...
# - Rendering the dashboard with the relevant sessions
# - Rendering the manage users page, to allow the admin to change user roles
# - change_permissions : change the permissions of the given user, i.e make admin etc
# This controller inherits from the Lecturer controller, so admins can
# share all the abilities of lecturers


class AdminController < LecturerController
  #Authorise without needing a model
  authorize_resource :class => false

  #Call the home method for lecturers
  def home
    @current_week = Time.now.utc.beginning_of_week
    begin
      @week_start = (params[:start_date] || "").to_datetime || @current_week
    rescue ArgumentError => e
      @week_start = @current_week
    end
    @week_start = @week_start.beginning_of_week
    @week_end = @week_start.end_of_week

    @sessions = TimetabledSession.all.where(start_time: @week_start..@week_end)
    @sessions = @sessions.order(created_at: :asc)
    render :dashboard
  end

  def manage_users
    @admins = User.all.where(admin: true).order("email ASC")
    @lecturers = User.all.where(lecturer: true,admin: false).order("email ASC")
  end

  #Post function for manage users
  def change_permissions
    #Get the user ID from params and attempt to find
    @user = User.find(params[:user_id])
    if (@user)
      #Find the action to perform
      action = params[:task]
      case action
      when "admin"
        @user.admin=true
        @user.lecturer=false
      when "lecturer"
        @user.admin=false
        @user.lecturer=true
      end

      @user.save
      redirect_to "/admin/manage", notice: "User updated"

    else
      redirect_to "/admin/manage", alert: "User not found"
    end

  end

  
  
end
