class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]
  before_filter :verify_coach, only: [:create]
  before_filter :verify_owns_group, only: [:show, :destroy]

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # POST /groups
  # POST /groups.json
  def create

    @group = current_user.build_group(group_params)

    @group.coach_user_id = current_user.id
    if @group.save
      render action: 'show', status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    if @group.update(group_params)
      head :no_content
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  #@TODO What to do with members that were a part of the group? have to loop through and call remove_user below
  def destroy
    @group.destroy
    head :no_content
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
    params.require(:group).permit(:name, :shared)
  end
end
