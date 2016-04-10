require 'rails_helper'

RSpec.describe UserSchedule, type: :model do

  context 'maintaining phases' do


    it 'updates the sprint diff if a user needs it' do
      user = FactoryGirl.create(:user, sprint_diff: 1)
      user_schedule = FactoryGirl.create(:user_schedule, user: user)
      start_date = Date.today - 5.weeks
      user_schedule.update_phases(start_date)
      dr = FactoryGirl.create(:daily_routine, user: user)
      sprint = FactoryGirl.create(:sprint, difficulty: 1)
      9.times do
        ps = FactoryGirl.create(:performed_sprint, daily_routine: dr, sprint: sprint)
        FactoryGirl.create(:lap, performed_sprint: ps, completed: true)
      end

      user_schedule.maintain_phases(Date.today)
      expect(user.reload.sprint_diff).to eq(2)
    end

    it 'does not update the sprint diff if not needed' do
      user = FactoryGirl.create(:user, sprint_diff: 1)
      user_schedule = FactoryGirl.create(:user_schedule, user: user)
      start_date = Date.today - 5.weeks
      user_schedule.update_phases(start_date)
      dr = FactoryGirl.create(:daily_routine, user: user)
      sprint = FactoryGirl.create(:sprint, difficulty: 1)
      7.times do
        ps = FactoryGirl.create(:performed_sprint, daily_routine: dr, sprint: sprint)
        FactoryGirl.create(:lap, performed_sprint: ps, completed: true)
      end

      user_schedule.maintain_phases(Date.today)
      expect(user.reload.sprint_diff).to eq(1)
    end
  end
end