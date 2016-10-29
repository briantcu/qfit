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
  before_filter :verify_logged_in
  before_action :set_friend, only: [:show]

  # GET /friends
  # GET /friends.json
  def index
    @friends = current_user.friends
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
  end

  private

  def set_friend
    @friend = Friend.find(params[:id])
  end
end
