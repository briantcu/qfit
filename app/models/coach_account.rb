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
#

class CoachAccount < ActiveRecord::Base
  belongs_to :user

  def is_maxed_out
    self.num_accts <= self.user.get_num_sub_users
  end
end
