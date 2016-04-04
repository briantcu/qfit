class CoachAccount < ActiveRecord::Base
  belongs_to :user
  has_many :players, through: :user
  has_many :coach_groups, through: :user

  def is_maxed_out?
    players.count >= num_accts
  end
end
