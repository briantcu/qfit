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

class Group < ActiveRecord::Base

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3


  belongs_to :user, :foreign_key => :coach_user_id
  has_many :group_joins
  has_many :users, :through => :group_joins
  has_one :group_schedule
  has_many :group_routines

  def get_schedule
    self.group_schedule
  end

  def create_routine(date)
    if self.group_schedule.is_valid_workout_day?(date)

    end
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
    self.users.each do |user|
      user.note_last_day_created(day_id, type)
    end
    self.save
  end
end
