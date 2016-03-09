require 'test_helper'

class LapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: laps
#
#  id                  :integer          not null, primary key
#  lap_number          :integer
#  performed_sprint_id :integer
#  completed           :boolean
#  created_at          :datetime
#  updated_at          :datetime
#
