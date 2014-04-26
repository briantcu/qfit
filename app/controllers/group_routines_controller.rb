class GroupRoutinesController < ApplicationController
  before_action :set_group_routine, only: [:show, :edit, :update, :destroy]

  # GET /group_routines
  # GET /group_routines.json
  def index
    @group_routines = GroupRoutine.all
  end

  # GET /group_routines/1
  # GET /group_routines/1.json
  def show
  end

  # GET /group_routines/new
  def new
    @group_routine = GroupRoutine.new
  end

  # GET /group_routines/1/edit
  def edit
  end

  # POST /group_routines
  # POST /group_routines.json
  def create
    @group_routine = GroupRoutine.new(group_routine_params)

    respond_to do |format|
      if @group_routine.save
        format.html { redirect_to @group_routine, notice: 'Group routine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_routine }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_routines/1
  # PATCH/PUT /group_routines/1.json
  def update
    respond_to do |format|
      if @group_routine.update(group_routine_params)
        format.html { redirect_to @group_routine, notice: 'Group routine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_routines/1
  # DELETE /group_routines/1.json
  def destroy
    @group_routine.destroy
    respond_to do |format|
      format.html { redirect_to group_routines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_routine
      @group_routine = GroupRoutine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_routine_params
      params.require(:group_routine).permit(:group_id, :day_performed, :program_day_id, :wt_day_id, :sp_day_id, :pl_day_id, :wu_day_id, :modified, :pl_modified, :wt_modified, :wu_modified, :sp_modified, :changes_saved)
    end
end
