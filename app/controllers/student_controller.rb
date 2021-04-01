#  The student controller manages the actions
#  for students

class StudentController < ApplicationController
  #Authorise without needing a model
  authorize_resource :class => StudentController

  #Show the Dashboard
  def code
  end

  def history 
    render :history
  end


  def validate
    @timetabled_session = TimetabledSession.find_by(validate_session_code_params)

    unless @timetabled_session.nil?
      @attendance = SessionAttendance.new(timetabled_session_id: @timetabled_session.id, user_id: current_user.id)
      if @attendance.save
        puts "---------------------------------"
        puts "Attendance registered succesfully"
        puts "---------------------------------"
        # redirect_to student_success_path, notice: 'Timetabled session was successfully created.'
      end
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def validate_session_code_params
      params.require(:session_code).permit(:session_code)
    end
end
