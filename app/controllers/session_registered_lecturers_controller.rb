class SessionRegisteredLecturersController < ApplicationController
  before_action :set_session_registered_lecturer, only: [:show, :edit, :update, :destroy]
  #Authorise
  authorize_resource
  
  # GET /session_registered_lecturers
  def index
    @session_registered_lecturers = SessionRegisteredLecturer.all
  end

  # GET /session_registered_lecturers/1
  def show
  end

  # GET /session_registered_lecturers/new
  def new
    @session_registered_lecturer = SessionRegisteredLecturer.new
  end

  # GET /session_registered_lecturers/1/edit
  def edit
  end

  # POST /session_registered_lecturers
  def create
    @session_registered_lecturer = SessionRegisteredLecturer.new(session_registered_lecturer_params)

    if @session_registered_lecturer.save
      redirect_to @session_registered_lecturer, notice: 'Session registered lecturer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /session_registered_lecturers/1
  def update
    if @session_registered_lecturer.update(session_registered_lecturer_params)
      redirect_to @session_registered_lecturer, notice: 'Session registered lecturer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /session_registered_lecturers/1
  def destroy
    @session_registered_lecturer.destroy
    redirect_to session_registered_lecturers_url, notice: 'Session registered lecturer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session_registered_lecturer
      @session_registered_lecturer = SessionRegisteredLecturer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def session_registered_lecturer_params
      params.require(:session_registered_lecturer).permit(:timetabled_session_id, :user_id)
    end
end
