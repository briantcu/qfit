require 'test_helper'

class GroupRoutineTest < ActiveSupport::TestCase
  test 'gets warmups without changes saved' do
    routine = GroupRoutine.find(1)
    routine.note_warmup_changes_saved
    assert(routine.changes_saved == true)
    assert(routine.wu_modified == true)
  end

  test 'adds a warm up' do
    routine = GroupRoutine.find(1)
    exercise = routine.add_warmup(2, 2, 0)
    assert(exercise != nil)
  end

  test 'notes day created' do
    routine = GroupRoutine.find(1)
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
    routine = GroupRoutine.find(1)
    routine.add_custom_exercise('custom', 2, '')
    assert(routine.group_custom_exercises.last.name == 'custom')
  end
end

# == Schema Information
#
# Table name: group_routines
#
#  id             :integer          not null, primary key
#  group_id       :integer
#  day_performed  :date
#  program_day_id :integer
#  wt_day_id      :integer
#  sp_day_id      :integer
#  pl_day_id      :integer
#  wu_day_id      :integer
#  modified       :boolean
#  pl_modified    :boolean
#  wt_modified    :boolean
#  wu_modified    :boolean
#  sp_modified    :boolean
#  changes_saved  :boolean
#  created_at     :datetime
#  updated_at     :datetime
#
