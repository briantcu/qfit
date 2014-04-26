class GroupPerformedSprintsController < ApplicationController
  before_action :set_group_performed_sprint, only: [:show, :edit, :update, :destroy]

  # GET /group_performed_sprints
  # GET /group_performed_sprints.json
  def index
    @group_performed_sprints = GroupPerformedSprint.all
  end

  # GET /group_performed_sprints/1
  # GET /group_performed_sprints/1.json
  def show
  end

  # GET /group_performed_sprints/new
  def new
    @group_performed_sprint = GroupPerformedSprint.new
  end

  # GET /group_performed_sprints/1/edit
  def edit
  end

  # POST /group_performed_sprints
  # POST /group_performed_sprints.json
  def create
    @group_performed_sprint = GroupPerformedSprint.new(group_performed_sprint_params)

    respond_to do |format|
      if @group_performed_sprint.save
        format.html { redirect_to @group_performed_sprint, notice: 'Group performed sprint was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_performed_sprint }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_performed_sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_performed_sprints/1
  # PATCH/PUT /group_performed_sprints/1.json
  def update
    respond_to do |format|
      if @group_performed_sprint.update(group_performed_sprint_params)
        format.html { redirect_to @group_performed_sprint, notice: 'Group performed sprint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_performed_sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_performed_sprints/1
  # DELETE /group_performed_sprints/1.json
  def destroy
    @group_performed_sprint.destroy
    respond_to do |format|
      format.html { redirect_to group_performed_sprints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_performed_sprint
      @group_performed_sprint = GroupPerformedSprint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_performed_sprint_params
      params.require(:group_performed_sprint).permit(:sprint_id, :status, :routine_id)
    end
end
