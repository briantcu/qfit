# == Schema Information
#
# Table name: groups
#
#  id                      :integer          not null, primary key
#  coach_user_id           :integer
#  name                    :string(255)
#  current_phase           :integer
#  sprint_diff             :integer          default(1)
#  last_weight_day_created :integer          default(0)
#  last_wu_day_created     :integer          default(0)
#  last_pl_day_created     :integer          default(0)
#  last_sp_day_created     :integer          default(0)
#  shared                  :boolean
#  created_at              :datetime
#  updated_at              :datetime
#  is_template             :boolean          default(FALSE)
#  program_type            :integer
#

class Group < ActiveRecord::Base

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  validates_length_of :name, maximum: 80

  belongs_to :coach, class_name: 'User', foreign_key: :coach_user_id
  has_many :group_joins, dependent: :destroy
  has_many :members, class_name: 'User', through: :group_joins
  has_one :group_schedule, dependent: :destroy
  has_many :group_routines

  scope :not_template, -> {where(is_template: false)}

  def get_schedule
    group_schedule
  end

  def is_group?
    true
  end

  def self.get_coach(group_id)
    group = Group.find(group_id)
    if group.present?
      return group.coach
    else
      return nil
    end
  end

  def exercise_tier
    # Don't need to check to see if the coach is in good standing here because we wouldn't be calling this if it wasn't
    @exercise_tier ||=
      if coach.coach_account.num_accts > 5
        2
      else
        1
      end
  end

  def will_workout_for_day?(day)
    self.group_schedule.group_schedule_days[day].stretching
  end

  def create_routine(date, custom = false)
    if self.group_schedule.is_valid_workout_day?(date) || custom
      group_routine = GroupRoutine.create_routine(self.id, date)
      self.members.each do |user|
        DailyRoutine.create_routine(user.id, date, group_routine.id, self.id)
      end
      group_routine
    end
  end

  def copy_workouts_to_user(user)
    return unless user.group.id == self.id
    open_workouts = RoutineService.get_open_workouts_start_today(self)
    open_workouts.each do |workout|
      workout.copy_to_user(user)
    end
  end

  def copy_schedule_to_user(user)
    return unless user.group.id == self.id
    group_schedule = self.group_schedule
    user_schedule = user.user_schedule
    if user_schedule.blank?
      user_schedule = UserSchedule.create_user_schedule({user_id: user.id, program_type_id: 1, program_id: 1}) # placeholder values
    end
    user_schedule.program_id = group_schedule.program_id
    user_schedule.phase_one_start = group_schedule.phase_one_start
    user_schedule.phase_two_start = group_schedule.phase_two_start
    user_schedule.phase_three_start = group_schedule.phase_three_start
    user_schedule.phase_four_start = group_schedule.phase_four_start
    user_schedule.save!
    group_schedule.group_schedule_days.each do |day|
      user_day = user_schedule.weekly_schedule_days.detect { |ud| ud.day == day.day}
      user_day.weights = day.weights
      user_day.plyometrics = day.plyometrics
      user_day.stretching = day.stretching
      user_day.sprinting = day.sprinting
      user_day.save!
    end
  end

  def update_program_info
    self.current_phase = self.group_schedule.get_current_phase
    self.save!
  end

  def note_last_day_created(day_id, type)
    case type
      when STRETCHING
        self.last_wu_day_created = day_id
      when WEIGHTS
        self.last_weight_day_created = day_id
      when PLYOS
        self.last_pl_day_created = day_id
      when SPRINTING
        self.last_sp_day_created = day_id
    end
    self.members.each do |user|
      user.note_last_day_created(day_id, type)
    end
    self.save
  end

  def get_last_day_created(type)
    case type
      when STRETCHING
        self.last_wu_day_created
      when WEIGHTS
        self.last_weight_day_created
      when PLYOS
        self.last_pl_day_created
      when SPRINTING
        self.last_sp_day_created
    end
  end

  def add_member(member)
    self.members.each do |teammate|
      FriendService.instance.make_friends(teammate.id, member.id)
    end
    self.members << member
    self.save!
  end
end
