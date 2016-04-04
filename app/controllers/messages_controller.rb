class MessagesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_message, only: [:show, :destroy]
  before_filter :verify_owns_message, only: [:show]

  # GET /messages.json
  def index
    @inbox = current_user.inbox.order(id: :desc).limit(10)
    @outbox = current_user.outbox.order(id: :desc).limit(10)
  end

  # GET /messages/1.json
  def show
  end

  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.poster = current_user.id

    if @message.save!
      render action: 'show', status: :created, location: @message
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

  def set_message
    @message = Message.find(params[:id])
  end
end
