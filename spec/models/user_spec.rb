# == Schema Information
#
# Table name: users
#
#  id                          :integer          not null, primary key
#  master_user_id              :integer
#  first_name                  :string(255)
#  last_name                   :string(255)
#  email                       :string(255)
#  sex                         :string(255)
#  administrator               :boolean          default(FALSE)
#  sub_user                    :boolean
#  knee_dom_max                :float
#  hor_push_max                :float
#  hor_pull_max                :float
#  power_index                 :integer
#  current_phase               :integer
#  phone                       :string(255)
#  last_weight_day_created     :integer          default(0)
#  last_warmup_day_created     :integer          default(0)
#  last_plyometric_day_created :integer          default(0)
#  last_sprint_day_created     :integer          default(0)
#  user_name                   :string(255)
#  sprint_diff                 :integer          default(1)
#  weight                      :float
#  program_type_id             :integer
#  birth_year                  :integer
#  subscription_date           :date
#  created_at                  :datetime
#  updated_at                  :datetime
#  encrypted_password          :string(255)      default(""), not null
#  reset_password_token        :string(255)
#  reset_password_sent_at      :datetime
#  remember_created_at         :datetime
#  sign_in_count               :integer          default(0), not null
#  current_sign_in_at          :datetime
#  last_sign_in_at             :datetime
#  current_sign_in_ip          :string(255)
#  last_sign_in_ip             :string(255)
#  authentication_token        :string(255)
#  experience_level            :integer
#  points                      :integer          default(10)
#  status                      :integer          default(1)
#  paid_tier                   :integer          default(1)
#  facebook                    :string
#  provider                    :string
#  uid                         :string
#  image                       :string
#  stripe_id                   :string
#  active_until                :datetime
#  subscription_id             :string
#  level                       :integer
#  needs_pw_reset              :boolean
#  avatar                      :string
#  failed_attempts             :integer          default(0), not null
#  unlock_token                :string
#  locked_at                   :datetime
#  bio                         :text
#

require 'rails_helper'

RSpec.describe User, type: :model do

  context 'scopes' do
    it 'returns active coaches' do
      active_coach = FactoryGirl.create(:user, level: 5, active_until: Time.zone.now + 7.days, status: 1)
      FactoryGirl.create(:coach_account, user: active_coach)

      past_due_coach = FactoryGirl.create(:user, level: 5, active_until: Time.zone.now - 1.days, status: 1)
      FactoryGirl.create(:coach_account, user: past_due_coach, num_accts: 6)

      unpaid_coach = FactoryGirl.create(:user, level: 5, active_until: Time.zone.now + 7.days, status: 3)
      FactoryGirl.create(:coach_account, user: unpaid_coach)

      overloaded_coach = FactoryGirl.create(:user, level: 5, active_until: Time.zone.now + 7.days, status: 1)
      FactoryGirl.create(:coach_account, user: overloaded_coach, num_accts: 6)
      7.times do
        FactoryGirl.create(:user, coach: overloaded_coach)
      end

      coaches = User.active_coaches
      expect(coaches.count).to eq(1)
      expect(coaches.first).to eq(active_coach)
    end
  end

  context 'facebook registration' do
    let(:params) { OpenStruct.new(:provider => 'facebook', :uid => '1k3kkd', :info => OpenStruct.new(email: 'bri.reg@gmail.com', image: 'path', first_name: 'brian', last_name: 'regan'))}

    it 'accepts a new facebook registration' do
      user = User.from_omniauth(params)
      expect(user.id).to eq(nil)
      expect(user.first_name).to eq('brian')
      expect(user.provider).to eq('facebook')
      expect(user.uid).to eq('1k3kkd')
      expect(user.email).to eq('bri.reg@gmail.com')
      expect(user.image).to eq('https?type=large')
    end

    it 'merges new facebook login with existing user' do
      existing = FactoryGirl.create(:user, email: 'bri.reg@gmail.com')
      user = User.from_omniauth(params)
      expect(user.id).to eq(existing.id)
      expect(user.provider).to eq('facebook')
      expect(user.uid).to eq('1k3kkd')
      expect(user.image).to eq('https?type=large')
    end

    it 'returns a returning facebook user' do
      existing = FactoryGirl.create(:user, email: 'bri.reg+1@gmail.com', provider: 'facebook', uid: '1k3kkd')
      user = User.from_omniauth(params)
      expect(user.id).to eq(existing.id)
      expect(user.provider).to eq('facebook')
      expect(user.uid).to eq('1k3kkd')
    end
  end

  context 'validation' do
    it 'does not allow invalid usernames' do
      user = User.new(user_name: 'thisismy&', email: 'test@test.com', password: 'pwdkflskdkf')
      expect(user.valid?).to be false

      user = User.new(user_name: 'thisismy*', email: 'test@test.com', password: 'pwdkflskdkf')
      expect(user.valid?).to be false

      user = User.new(user_name: 'thisi smy', email: 'test@test.com', password: 'pwdkflskdkf')
      expect(user.valid?).to be false

      user = User.new(user_name: 'thi.smy', email: 'test@test.com', password: 'pwdkflskdkf')
      expect(user.valid?).to be false
    end

    it 'allows valid usernames' do
      user = User.new(user_name: 'thisismy', email: 'test@test.com', password: 'pwdkflskdkf')
      expect(user.valid?).to be true

      user = User.new(user_name: 'thi889_sismy', email: 'test@test.com', password: 'pwdkflskdkf')
      expect(user.valid?).to be true

      user = User.new(user_name: 'thisi---__my', email: 'test@test.com', password: 'pwdkflskdkf')
      expect(user.valid?).to be true
    end
  end
end
