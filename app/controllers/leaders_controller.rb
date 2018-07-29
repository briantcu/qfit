# == Schema Information
#
# Table name: leaders
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  first_name  :string(255)
#  last_name   :string(255)
#  value       :string(255)
#  leader_type :integer
#  created     :date
#  created_at  :datetime
#  updated_at  :datetime
#

class LeadersController < ApplicationController

  # GET /leaders.json
  def index
  end

end
