class TimetabledSessionsController < ApplicationController
  before_action :set_timetabled_session, only: [:show, :edit, :update, :destroy]
  #Authorise
  authorize_resource
  # GET /timetabled_sessions
  def index
    @timetabled_sessions = TimetabledSession.all
  end

  # GET /timetabled_sessions/1
  def show
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

    if @timetabled_session.save
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
      params.require(:timetabled_session).permit(:session_code, :session_title, :module_code, :start_time, :end_time, :creator, :report_email)
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
