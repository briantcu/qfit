# == Schema Information
#
# Table name: routine_messages
#
#  id               :integer          not null, primary key
#  daily_routine_id :integer
#  message          :text
#  created_at       :datetime
#  updated_at       :datetime
#

class RoutineMessages < ActiveRecord::Base
  belongs_to :daily_routine, dependent: :destroy
end
