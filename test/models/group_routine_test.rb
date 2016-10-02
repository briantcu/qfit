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
#  modified       :boolean          default(FALSE)
#  pl_modified    :boolean          default(FALSE)
#  wt_modified    :boolean          default(FALSE)
#  wu_modified    :boolean          default(FALSE)
#  sp_modified    :boolean          default(FALSE)
#  changes_saved  :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#

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
