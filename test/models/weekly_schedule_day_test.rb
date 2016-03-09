require 'test_helper'

class WeeklyScheduleDayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: weekly_schedule_days
#
#  id               :integer          not null, primary key
#  day              :integer
#  user_schedule_id :integer
#  weights          :boolean
#  plyometrics      :boolean
#  stretching       :boolean
#  sprinting        :boolean
#  created_at       :datetime
#  updated_at       :datetime
#
