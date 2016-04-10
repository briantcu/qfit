require 'test_helper'

class GroupRoutineTest < ActiveSupport::TestCase
  test 'gets warmups without changes saved' do
    group = FactoryGirl.create(:group)
    routine = FactoryGirl.create(:group_routine, group: group)
    routine.note_warmup_changes_saved
    assert(routine.changes_saved == true)
    assert(routine.wu_modified == true)
  end

  test 'adds a warm up' do
    group = FactoryGirl.create(:group)
    routine = FactoryGirl.create(:group_routine, group: group)
    exercise = routine.add_warmup(2, 2, 0)
    assert(exercise != nil)
  end

  test 'notes day created' do
    group = FactoryGirl.create(:group)
    routine = FactoryGirl.create(:group_routine, group: group)
    routine.note_day_created(3, 1)
    assert(routine.wt_day_id == 3)

    routine.note_day_created(4, 2)
    assert(routine.pl_day_id == 4)

    routine.note_day_created(2, 3)
    assert(routine.sp_day_id == 2)

    routine.note_day_created(5, 4)
    assert(routine.wu_day_id == 5)
  end

  test 'adds custom exercise' do
    group = FactoryGirl.create(:group)
    routine = FactoryGirl.create(:group_routine, group: group)
    routine.add_custom_exercise('custom', 2, '')
    assert(routine.group_custom_exercises.last.name == 'custom')
  end
end
