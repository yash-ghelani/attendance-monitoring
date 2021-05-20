
# This controller manages the attendance for
# a session, it is a resource controller which means it provides basic CRUD
# functions for managing the attendance of a session 

class SessionAttendancesController < ApplicationController
  before_action :set_session_attendance, only: [:show, :edit, :update, :destroy]
  #Authorise
  authorize_resource
  

  # GET /session_attendances
  def index
    @session_attendances = SessionAttendance.includes(:user, :timetabled_session).all
  end

  # GET /session_attendances/1
  def show
    @timetabled_session = TimetabledSession.includes(:users, :session_attendances).find(params[:id])
  end

  # GET /session_attendances/new
  def new
    @session_attendance = SessionAttendance.new
  end

  # GET /session_attendances/1/edit
  def edit
  end

  # POST /session_attendances
  def create
    @session_attendance = SessionAttendance.new(session_attendance_params)

    if @session_attendance.save
      redirect_to @session_attendance, notice: 'Session attendance was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /session_attendances/1
  def update
    if @session_attendance.update(session_attendance_params)
      redirect_to @session_attendance, notice: 'Session attendance was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /session_attendances/1
  def destroy
    @session_attendance.destroy
    redirect_to session_attendances_url, notice: 'Session attendance was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session_attendance
      @session_attendance = SessionAttendance.find_by(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def session_attendance_params
      params.require(:session_attendance).permit(:timetabled_session_id, :user_id)
    end
end
