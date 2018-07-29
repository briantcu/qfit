# == Schema Information
#
# Table name: user_maxes
#
#  id          :integer          not null, primary key
#  exercise_id :integer
#  user_id     :integer
#  max         :float
#  created_at  :datetime
#  updated_at  :datetime
#

class UserMaxesController < ApplicationController
  before_filter :verify_logged_in

  # GET /user_maxes.json
  def index
    @user_maxes = UserMax.for_user(current_user)
  end

end
