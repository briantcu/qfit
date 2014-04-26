class GroupJoinsController < ApplicationController
  before_action :set_group_join, only: [:show, :edit, :update, :destroy]

  # GET /group_joins
  # GET /group_joins.json
  def index
    @group_joins = GroupJoin.all
  end

  # GET /group_joins/1
  # GET /group_joins/1.json
  def show
  end

  # GET /group_joins/new
  def new
    @group_join = GroupJoin.new
  end

  # GET /group_joins/1/edit
  def edit
  end

  # POST /group_joins
  # POST /group_joins.json
  def create
    @group_join = GroupJoin.new(group_join_params)

    respond_to do |format|
      if @group_join.save
        format.html { redirect_to @group_join, notice: 'Group join was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_join }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_join.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_joins/1
  # PATCH/PUT /group_joins/1.json
  def update
    respond_to do |format|
      if @group_join.update(group_join_params)
        format.html { redirect_to @group_join, notice: 'Group join was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_join.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_joins/1
  # DELETE /group_joins/1.json
  def destroy
    @group_join.destroy
    respond_to do |format|
      format.html { redirect_to group_joins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_join
      @group_join = GroupJoin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_join_params
      params.require(:group_join).permit(:group_id, :user_id)
    end
end
