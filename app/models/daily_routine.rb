# == Schema Information
#
# Table name: daily_routines
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  group_id           :integer
#  day_performed      :date
#  weight             :integer
#  power_index        :integer
#  count_ex_provided  :integer
#  count_ex_completed :integer
#  program_day_id     :integer
#  wt_day_id          :integer
#  sp_day_id          :integer
#  pl_day_id          :integer
#  wu_day_id          :integer
#  modified           :boolean
#  pl_modified        :boolean
#  wt_modified        :boolean
#  wu_modified        :boolean
#  sp_modified        :boolean
#  changes_saved      :boolean
#  closed             :boolean
#  created_at         :datetime
#  updated_at         :datetime
#

class DailyRoutine < ActiveRecord::Base
end
