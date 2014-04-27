# == Schema Information
#
# Table name: group_performed_warmups
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  warmup_id  :integer
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupPerformedWarmup < ActiveRecord::Base
  belongs_to :group_routine
end
