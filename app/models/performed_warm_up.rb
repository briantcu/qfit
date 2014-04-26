# == Schema Information
#
# Table name: performed_warm_ups
#
#  id              :integer          not null, primary key
#  routine_id      :integer
#  warmup_id       :integer
#  status          :integer
#  group_warmup_id :integer
#  completed       :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

class PerformedWarmUp < ActiveRecord::Base
end
