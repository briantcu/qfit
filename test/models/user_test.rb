require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should create a workout routine according to schedule' do
    user = User.find(1)
    routine = user.create_routine(Date.new(2014, 4, 27))
    assert(routine != nil)
  end

  test 'should not create a workout routine if there is not one scheduled' do
    user = User.find(1)
    routine = user.create_routine(Date.new(2014, 4, 28))
    assert(routine.nil?)
  end

  test 'should note day created' do
    user = User.find(1)
    user.note_last_day_created(2, 1)
    assert(user.last_weight_day_created == 2)

    user.note_last_day_created(2, 2)
    assert(user.last_plyometric_day_created == 2)

    user.note_last_day_created(2, 3)
    assert(user.last_sprint_day_created == 2)

    user.note_last_day_created(2, 4)
    assert(user.last_warmup_day_created == 2)
  end


end

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
#  administrator               :boolean
#  sub_user                    :boolean
#  knee_dom_max                :float
#  hor_push_max                :float
#  hor_pull_max                :float
#  power_index                 :integer
#  old_password                :string(255)
#  current_phase               :integer
#  phone                       :string(255)
#  last_weight_day_created     :integer          default(0)
#  last_warmup_day_created     :integer          default(0)
#  last_plyometric_day_created :integer          default(0)
#  last_sprint_day_created     :integer          default(0)
#  user_name                   :string(255)
#  sprint_diff                 :integer          default(1)
#  weight                      :float
#  level                       :integer
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
#  displayed_user_name         :string(255)
#  points                      :integer
#  avatars                     :json
#  status                      :integer          default(1)
#
