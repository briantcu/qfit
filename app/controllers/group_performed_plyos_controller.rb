# == Schema Information
#
# Table name: group_performed_plyos
#
#  id            :integer          not null, primary key
#  plyometric_id :integer
#  routine_id    :integer
#  status        :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class GroupPerformedPlyosController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_group_performed_plyo, only: [:update, :destroy]
  before_filter :verify_owns_group, only: [:update, :destroy]

  # PATCH/PUT /group_performed_plyos/1.json
  def update
    if @group_performed_plyo.plyometric_id != params[:group_performed_plyo][:plyometric_id]
      @group_performed_plyo.update_ex(group_performed_plyo_params)
      render action: 'show', status: :ok, location: @group_performed_plyo
    else
      render json: @group_performed_plyo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_performed_plyos/1.json
  def destroy
    @group_performed_plyo.destroy_ex
    render json: {success: true}
  end

  private
  def set_group_performed_plyo
    @group_performed_plyo = GroupPerformedPlyo.find(params[:id])
  end

  def group_performed_plyo_params
    params.require(:group_performed_plyo).permit(:plyometric_id)
  end

  def verify_owns_group
    unauthorized unless (current_user.owns_group?(@group_performed_plyo.routine_id))
  end
end
