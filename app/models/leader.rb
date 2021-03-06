# == Schema Information
#
# Table name: leaders
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  first_name  :string(255)
#  last_name   :string(255)
#  value       :string(255)
#  leader_type :integer
#  created     :date
#  created_at  :datetime
#  updated_at  :datetime
#

class Leader < ActiveRecord::Base
  MALE_POWER_INDEX = 1
  FEMALE_POWER_INDEX = 2
  MALE_POWER_INDEX_RATIO = 3
  FEMALE_POWER_INDEX_RATIO = 4
  SPRINTS_PERFORMED = 5
  PLYOS_PERFORMED = 6
  SETS_PERFORMED = 7
  REPS_PERFORMED = 8
  belongs_to :user

  scope :male_power_index, -> {where(leader_type: MALE_POWER_INDEX).joins(:user).includes(:user).order(value: :desc)}
  scope :female_power_index, -> {where(leader_type: FEMALE_POWER_INDEX).joins(:user).includes(:user).order(value: :desc)}
  scope :male_power_index_ratio, -> {where(leader_type: MALE_POWER_INDEX_RATIO).joins(:user).includes(:user).order(value: :desc)}
  scope :female_power_index_ratio, -> {where(leader_type: FEMALE_POWER_INDEX_RATIO).joins(:user).includes(:user).order(value: :desc)}
  scope :sprints_performed, -> {where(leader_type: SPRINTS_PERFORMED).joins(:user).includes(:user).order(value: :desc)}
  scope :plyos_performed, -> {where(leader_type: PLYOS_PERFORMED).joins(:user).includes(:user).order(value: :desc)}
  scope :sets_performed, -> {where(leader_type: SETS_PERFORMED).joins(:user).includes(:user).order(value: :desc)}
  scope :reps_performed, -> {where(leader_type: REPS_PERFORMED).joins(:user).includes(:user).order(value: :desc)}
end
