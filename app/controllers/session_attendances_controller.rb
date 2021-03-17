class SessionAttendancesController < ApplicationController
  before_action :set_session_attendance, only: [:show, :edit, :update, :destroy]

  # GET /session_attendances
  def index
    @session_attendances = SessionAttendance.all
  end

  # GET /session_attendances/1
  def show
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
      @session_attendance = SessionAttendance.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def session_attendance_params
      params.require(:session_attendance).permit(:joined_at)
    end
end
