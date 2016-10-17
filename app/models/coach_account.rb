# == Schema Information
#
# Table name: coach_accounts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  num_accts     :integer
#  billing_email :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  active        :boolean          default(TRUE)
#  active_until  :datetime
#

class CoachAccount < ActiveRecord::Base
  belongs_to :user
  has_many :players, through: :user
  has_many :coach_groups, through: :user

  def is_maxed_out?
    players.count >= num_accts
  end

  def is_overloaded?
    players.count > num_accts
  end

  def can_send_codes?
    (user.sign_up_codes.unused.count + players.count) < num_accts
  end
end
