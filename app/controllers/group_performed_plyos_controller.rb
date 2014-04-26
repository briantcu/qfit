class GroupPerformedPlyosController < ApplicationController
  before_action :set_group_performed_plyo, only: [:show, :edit, :update, :destroy]

  # GET /group_performed_plyos
  # GET /group_performed_plyos.json
  def index
    @group_performed_plyos = GroupPerformedPlyo.all
  end

  # GET /group_performed_plyos/1
  # GET /group_performed_plyos/1.json
  def show
  end

  # GET /group_performed_plyos/new
  def new
    @group_performed_plyo = GroupPerformedPlyo.new
  end

  # GET /group_performed_plyos/1/edit
  def edit
  end

  # POST /group_performed_plyos
  # POST /group_performed_plyos.json
  def create
    @group_performed_plyo = GroupPerformedPlyo.new(group_performed_plyo_params)

    respond_to do |format|
      if @group_performed_plyo.save
        format.html { redirect_to @group_performed_plyo, notice: 'Group performed plyo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_performed_plyo }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_performed_plyo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_performed_plyos/1
  # PATCH/PUT /group_performed_plyos/1.json
  def update
    respond_to do |format|
      if @group_performed_plyo.update(group_performed_plyo_params)
        format.html { redirect_to @group_performed_plyo, notice: 'Group performed plyo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_performed_plyo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_performed_plyos/1
  # DELETE /group_performed_plyos/1.json
  def destroy
    @group_performed_plyo.destroy
    respond_to do |format|
      format.html { redirect_to group_performed_plyos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_performed_plyo
      @group_performed_plyo = GroupPerformedPlyo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_performed_plyo_params
      params.require(:group_performed_plyo).permit(:plyometric_id, :routine_id, :status)
    end
end
