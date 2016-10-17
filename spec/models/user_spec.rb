require 'rails_helper'

RSpec.describe User, type: :model do

  context 'scopes' do
    it 'returns active coaches' do
      active_coach = FactoryGirl.create(:user, administrator: true, active_until: Time.now + 7.days, status: 1)
      FactoryGirl.create(:coach_account, user: active_coach)

      past_due_coach = FactoryGirl.create(:user, administrator: true, active_until: Time.now - 1.days, status: 1)
      FactoryGirl.create(:coach_account, user: past_due_coach)

      unpaid_coach = FactoryGirl.create(:user, administrator: true, active_until: Time.now + 7.days, status: 3)
      FactoryGirl.create(:coach_account, user: unpaid_coach)

      overloaded_coach = FactoryGirl.create(:user, administrator: true, active_until: Time.now + 7.days, status: 1)
      FactoryGirl.create(:coach_account, user: overloaded_coach, num_accts: 1)
      2.times do
        FactoryGirl.create(:user, coach: overloaded_coach)
      end

      coaches = User.active_coaches
      expect(coaches.count).to eq(1)
      expect(coaches.first).to eq(active_coach)
    end
  end
end