require 'test_helper'

class PerformedPlyometricTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: performed_plyometrics
#
#  id                            :integer          not null, primary key
#  plyometric_id                 :integer
#  routine_id                    :integer
#  status                        :integer
#  group_performed_plyometric_id :integer
#  performed_one                 :boolean
#  performed_two                 :boolean
#  performed_three               :boolean
#  created_at                    :datetime
#  updated_at                    :datetime
#
