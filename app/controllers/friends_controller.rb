class FriendsController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_friend, only: [:show, :destroy]

  # GET /friends
  # GET /friends.json
  def index
    current_user.friends
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:id_one, :id_two)
    end
end
