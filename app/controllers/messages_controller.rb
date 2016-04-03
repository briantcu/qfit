class MessagesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages.json
  def index
    @messages = Message.all
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

  # PATCH/PUT /messages/1.json
  def update
    if @message.update(message_params)
      head :no_content
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
  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:message, :parent_id, :to_id, :message_type)
  end
end
