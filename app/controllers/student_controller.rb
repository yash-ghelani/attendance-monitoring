#  The student controller manages the actions
#  for students

class StudentController < ApplicationController
  #Authorise without needing a model
  authorize_resource :class => StudentController

  #Show the Dashboard
  def code
    # The qrcode variable is an optional variable that
    # could exist in the URL, for example /student?qrcode=abc123
    # This will be automatically added to the code field
    @qrcode = params[:qrcode]
    # Attempt to find timetable session for that code
    @timetabled_session = TimetabledSession.find_by(session_code: @qrcode)
  end

  def history 
    @history = TimetabledSession.joins(:session_attendances => :user).where(session_attendances: {user: current_user})

    render :history
  end


  def validate
    if /^[\d\w-]+$/.match(validate_params["session_code"]).nil?
      redirect_to student_path, alert: 'Code must contain only digits, letters and dashes'
    elsif /^[\d\w]{8,}$/.match(validate_params["session_code"]).nil?
      redirect_to student_path, alert: 'Code must be of length 8'
    else
      @timetabled_session = TimetabledSession.find_by(validate_params)

      if @timetabled_session.nil?
        redirect_to student_path, alert: 'No session found for that code'
      elsif @timetabled_session.start_time-15.minutes > Time.now.utc
        redirect_to student_path, alert: 'Session has not opened attendance yet'
      elsif Time.now > @timetabled_session.end_time
        redirect_to student_path, alert: 'Session has ended. Deadline for signing in has passed for the session'
      else
        @attendance = SessionAttendance.new(timetabled_session: @timetabled_session, user: current_user)
        if @attendance.save
          puts "---------------------------------"
          puts "Attendance registered succesfully"
          puts "---------------------------------"
          redirect_to student_history_path, notice: 'Successfully signed in!'
        end
      end
    end
  end

  def quickValidate
    #THE ajax function for student, will attempt to find session matching request
    @timetabled_session = TimetabledSession.find_by(session_code: params[:session_code])
    respond_to do |format|
      format.html
      format.json {render json: @timetabled_session}
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def validate_params
      params.require(:session_code).permit(:session_code)
    end
  end
