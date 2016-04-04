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
