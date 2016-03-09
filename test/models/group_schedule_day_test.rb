require 'test_helper'

class GroupScheduleDayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: group_schedule_days
#
#  id                :integer          not null, primary key
#  group_schedule_id :integer
#  weights           :boolean
#  plyometrics       :boolean
#  stretching        :boolean
#  sprinting         :boolean
#  created_at        :datetime
#  updated_at        :datetime
#  day               :integer
#
