require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test 'should note day created' do
    group = Group.find(1)
    group.note_last_day_created(2, 1)
    assert(group.last_weight_day_created == 2)

    group.note_last_day_created(2, 2)
    assert(group.last_pl_day_created == 2)

    group.note_last_day_created(2, 3)
    assert(group.last_sp_day_created == 2)

    group.note_last_day_created(2, 4)
    assert(group.last_wu_day_created == 2)
  end
end

# == Schema Information
#
# Table name: groups
#
#  id                      :integer          not null, primary key
#  coach_user_id           :integer
#  name                    :string(255)
#  current_phase           :integer
#  sprint_diff             :integer
#  last_weight_day_created :integer
#  last_wu_day_created     :integer
#  last_pl_day_created     :integer
#  last_sp_day_created     :integer
#  shared                  :boolean
#  created_at              :datetime
#  updated_at              :datetime
#
