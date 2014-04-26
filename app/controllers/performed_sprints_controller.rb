class PerformedSprintsController < ApplicationController
  before_action :set_performed_sprint, only: [:show, :edit, :update, :destroy]

  # GET /performed_sprints
  # GET /performed_sprints.json
  def index
    @performed_sprints = PerformedSprint.all
  end

  # GET /performed_sprints/1
  # GET /performed_sprints/1.json
  def show
  end

  # GET /performed_sprints/new
  def new
    @performed_sprint = PerformedSprint.new
  end

  # GET /performed_sprints/1/edit
  def edit
  end

  # POST /performed_sprints
  # POST /performed_sprints.json
  def create
    @performed_sprint = PerformedSprint.new(performed_sprint_params)

    respond_to do |format|
      if @performed_sprint.save
        format.html { redirect_to @performed_sprint, notice: 'Performed sprint was successfully created.' }
        format.json { render action: 'show', status: :created, location: @performed_sprint }
      else
        format.html { render action: 'new' }
        format.json { render json: @performed_sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performed_sprints/1
  # PATCH/PUT /performed_sprints/1.json
  def update
    respond_to do |format|
      if @performed_sprint.update(performed_sprint_params)
        format.html { redirect_to @performed_sprint, notice: 'Performed sprint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @performed_sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performed_sprints/1
  # DELETE /performed_sprints/1.json
  def destroy
    @performed_sprint.destroy
    respond_to do |format|
      format.html { redirect_to performed_sprints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performed_sprint
      @performed_sprint = PerformedSprint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performed_sprint_params
      params.require(:performed_sprint).permit(:sprint_id, :status, :group_performed_sprint_id, :routine_id)
    end
end
