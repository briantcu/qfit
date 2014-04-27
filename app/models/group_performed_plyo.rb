# == Schema Information
#
# Table name: group_performed_plyos
#
#  id            :integer          not null, primary key
#  plyometric_id :integer
#  routine_id    :integer
#  status        :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class GroupPerformedPlyo < ActiveRecord::Base
  belongs_to :group_routine
end
