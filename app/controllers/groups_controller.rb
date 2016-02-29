class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_filter :verify_coach, only: [:create]
  before_filter :verify_owns_group, only: [:destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create

    @group = current_user.build_group(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  def new_user
    user = User.find(params[:user_id])
    return unauthorized unless current_user.is_coach_of_user?(user.id)
    @group.add_user(user)
    RoutineService.group_status_changed(user)
  end

  def remove_user
    user = User.find(params[:user_id])
    return unauthorized unless current_user.is_coach_of_user?(user.id)
    GroupJoin.find_by(group_id: @group.id, user_id: user.id).destroy!
    RoutineService.group_status_changed(user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  def verify_coach
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.is_coach?)
  end

  def verify_owns_group
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.is_coach? && (@group.coach_user_id == current_user.id))
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:coach_user_id, :name, :shared)
  end
end
