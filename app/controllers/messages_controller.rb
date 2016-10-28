# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  poster_id    :integer
#  message      :text
#  parent_id    :integer
#  to_id        :integer
#  message_type :integer
#  created_at   :datetime
#  updated_at   :datetime
#  seen         :boolean
#

class MessagesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_message, only: [:show, :destroy]
  before_filter :verify_owns_message, only: [:show]
  before_filter :are_friends_for_dm, only: [:create]
  before_filter :are_friends, only: [:conversation]

  # GET /messages.json
  def index
    @inbox = current_user.inbox.order(id: :desc).limit(10)
    @outbox = current_user.outbox.order(id: :desc).limit(10)
  end

  # GET /messages/1.json
  def show
  end

  # GET /messages/user_id/1.json
  def conversation
    @messages = Message.conversation(current_user.id, params[:user_id])
    @user = User.find(params[:user_id])
  end

  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.poster = current_user

    if @message.save!
      render action: 'show', status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1.json
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def verify_owns_message
    unauthorized unless (@message.poster_id == current_user.id) || (@message.to_id == current_user.id)
  end

  def message_params
    params.require(:message).permit(:message, :parent_id, :to_id, :message_type)
  end

  def are_friends_for_dm
    if params[:message][:message_type] == 2
      unauthorized unless FriendService.instance.are_friends?(current_user.id, params[:message][:to_id])
    end
  end

  def are_friends
    unauthorized unless FriendService.instance.are_friends?(current_user.id, params[:user_id])
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
