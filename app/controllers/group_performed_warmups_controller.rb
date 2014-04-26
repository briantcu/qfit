class GroupPerformedWarmupsController < ApplicationController
  before_action :set_group_performed_warmup, only: [:show, :edit, :update, :destroy]

  # GET /group_performed_warmups
  # GET /group_performed_warmups.json
  def index
    @group_performed_warmups = GroupPerformedWarmup.all
  end

  # GET /group_performed_warmups/1
  # GET /group_performed_warmups/1.json
  def show
  end

  # GET /group_performed_warmups/new
  def new
    @group_performed_warmup = GroupPerformedWarmup.new
  end

  # GET /group_performed_warmups/1/edit
  def edit
  end

  # POST /group_performed_warmups
  # POST /group_performed_warmups.json
  def create
    @group_performed_warmup = GroupPerformedWarmup.new(group_performed_warmup_params)

    respond_to do |format|
      if @group_performed_warmup.save
        format.html { redirect_to @group_performed_warmup, notice: 'Group performed warmup was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_performed_warmup }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_performed_warmup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_performed_warmups/1
  # PATCH/PUT /group_performed_warmups/1.json
  def update
    respond_to do |format|
      if @group_performed_warmup.update(group_performed_warmup_params)
        format.html { redirect_to @group_performed_warmup, notice: 'Group performed warmup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_performed_warmup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_performed_warmups/1
  # DELETE /group_performed_warmups/1.json
  def destroy
    @group_performed_warmup.destroy
    respond_to do |format|
      format.html { redirect_to group_performed_warmups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_performed_warmup
      @group_performed_warmup = GroupPerformedWarmup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_performed_warmup_params
      params.require(:group_performed_warmup).permit(:routine_id, :warmup_id, :status)
    end
end
