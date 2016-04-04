class UserMaxesController < ApplicationController
  before_filter :verify_logged_in

  # GET /user_maxes.json
  def index
    @user_maxes = UserMax.for_user(current_user)
  end

end
