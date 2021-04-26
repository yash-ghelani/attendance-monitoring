
require 'uri'

class TimetabledSessionsController < ApplicationController
  before_action :set_timetabled_session, only: [:show, :edit, :update, :destroy, :sam]
  #Authorise
  authorize_resource

  #Ajax function, returns number of attendees for session
  def quick_get_attendance_count
    @count = TimetabledSession.find(params[:session_id]).attendees.count
    respond_to do |format|
      format.html
      format.json {render json: @count}
    end
  end

  # GET /timetabled_sessions
  def index
    @timetabled_sessions = TimetabledSession.all
  end

  # GET /timetabled_sessions/1
  def show
    #Create a URL variable for the QR code to use
    @url = URI.encode("#{root_url}student?qrcode=#{@timetabled_session.session_code}")
  end

  def attendances
    @timetabled_session = TimetabledSession.includes(:session_attendances => :user).find(params[:id])
  end

  def sam
    respond_to do |format|
      format.html
      format.csv {send_data @timetabled_session.to_csv, filename: "SAM-#{@timetabled_session.session_title.parameterize}.csv", type: 'text/csv; charset=utf-8'}
    end
  end

  def bulk_sam
    if params[:start_date] && params[:end_date]
      start_date = params[:start_date].to_datetime
      end_date = params[:end_date].to_datetime
      @timetabled_sessions = TimetabledSession.where(start_time: start_date..end_date)
      respond_to do |format|
        format.html
        format.csv {send_data @timetabled_sessions.to_csv(current_user), filename: "SAM-#{start_date.strftime('%Y%m%d')}-#{end_date.strftime('%Y%m%d')}.csv", type: 'text/csv; charset=utf-8'}
      end
    end
  end

  # GET /timetabled_sessions/new
  def new
    @timetabled_session = TimetabledSession.new
  end

  # GET /timetabled_sessions/1/edit
  def edit
  end

  # POST /timetabled_sessions
  def create
    @timetabled_session = TimetabledSession.new(timetabled_session_params)

    if @timetabled_session.save!
      if current_user.lecturer?
        SessionRegisteredLecturer.create(user: current_user, timetabled_session: @timetabled_session)
      end

      redirect_to @timetabled_session, notice: 'Timetabled session was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /timetabled_sessions/1
  def update
    if @timetabled_session.update(timetabled_session_params)
      redirect_to @timetabled_session, notice: 'Timetabled session was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /timetabled_sessions/1
  def destroy
    @timetabled_session.destroy
    redirect_to lecturer_url, notice: 'Timetabled session was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timetabled_session
      @timetabled_session = TimetabledSession.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def timetabled_session_params
      params.require(:timetabled_session).permit(
        :session_title, :module_code, :start_time, :end_time, 
        session_registered_lecturers_attributes: [:user_id, :id, :_destroy]
      ).merge(creator: current_user, report_email: current_user.email)
    end

    def generate_code(number)
      charset = Array('A'..'Z') + Array('a'..'z') + Array(['0','1','2','3','4','5','6','7','8','9'])
      Array.new(number) { charset.sample }.join
    end

    def update_code
      timetabled_session = TimetabledSession.find(params[:id])
      timetabled_session.update_attribute(:session_code, generate_code(8))
    end
    helper_method :update_code
end
