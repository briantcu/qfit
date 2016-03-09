require 'test_helper'

class GroupScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: group_schedules
#
#  id                :integer          not null, primary key
#  group_id          :integer
#  program_id        :integer
#  phase_one_start   :date
#  phase_two_start   :date
#  phase_three_start :date
#  phase_four_start  :date
#  created_at        :datetime
#  updated_at        :datetime
#
