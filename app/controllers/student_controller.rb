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
    
    @current_week = Time.now.utc.beginning_of_week
    begin
      @week_start = (params[:start_date] || "").to_datetime || @current_week
    rescue ArgumentError => e
      @week_start = @current_week
    end
    @week_start = @week_start.beginning_of_week
    @week_end = @week_start.end_of_week
    
    @history = @history.where(start_time: @week_start..@week_end)
    @history = @history.order(created_at: :asc)

    render :history
  end

  def validate
    @timetabled_session, errors = validation_errors(params[:session_code])

    respond_to do |format|
      response = {session: @timetabled_session, errors: errors}
      format.json {render json: response}
    end
  end

  def attend
    @timetabled_session, errors = validation_errors(validate_params['session_code'])
    if errors.length > 0
      redirect_to student_path, alert: errors.last
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

  private
    # Only allow a trusted parameter "white list" through.
    def validate_params
      params.require(:session_code).permit(:session_code)
    end

    def validation_errors(session_code)
      errors = []
      timetabled_session = nil
      if /^[\d\w-]+$/.match(session_code).nil?
        errors.push 'Code must contain only digits and letters.'
      elsif /^[\d\w]{8,}$/.match(session_code).nil?
        errors.push 'Code must be of length 8'
      else
        timetabled_session = TimetabledSession.find_by(session_code: session_code)

        if timetabled_session.nil?
          errors.push 'No session found for that code'
        elsif timetabled_session.start_time-15.minutes > Time.now
          errors.push 'Session has not opened attendance yet'
        elsif Time.now > timetabled_session.end_time
          errors.push 'Session has ended. Deadline for signing in has passed for the session'
        end

        unless timetabled_session.nil?
          attendance = SessionAttendance.find_by(timetabled_session: timetabled_session, user: current_user)
          unless attendance.nil?
            errors.push 'You have already marked attendance for this session'
          end
        end
      end

      return timetabled_session, errors
    end
  end
