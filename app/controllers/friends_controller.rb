# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  id_one     :integer
#  id_two     :integer
#  created_at :datetime
#  updated_at :datetime
#

class FriendsController < ApplicationController
  before_filter :verify_logged_in, except: [:friends_for_user, :show]

  # GET /friends
  # GET /friends.json
  def index
    @friends = current_user.friends
  end

  def friends_for_user
    user = User.find(params[:id])
    @friends = user.friends.limit(10)
  end

  def destroy
    record = FriendService.instance.get_friends_record(current_user.id, params[:id])
    if record.present?
      record.destroy!
    end
    @friends = current_user.friends
    render action: :index, status: :ok
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    # Used to populate the profile page
    @user = User.find(params[:id])

    @is_friend = false
    if current_user.present?
      @is_friend = FriendService.instance.are_friends?(@user.id, current_user.id)
    end

    if @is_friend || ( current_user.present? && (current_user.id == @user.id))
      @recent_workouts = @user.recent_workouts
    else
      @recent_workouts = []
    end
  end
end
