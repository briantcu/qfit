class FriendsController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_friend, only: [:show]

  # GET /friends
  # GET /friends.json
  def index
    current_user.friends
  end

  # GET /friends/1
  # GET /friends/1.json
  #@TODO this endpoint can return profile detes for this user you're friends with. Need to verify you're friends
  def show
  end

  private

  def set_friend
    @friend = Friend.find(params[:id])
  end
end
