# == Schema Information
#
# Table name: sprint_detail_sequences
#
#  id         :integer          not null, primary key
#  sprint_id  :integer
#  detail_num :integer
#  order_num  :integer
#  created_at :datetime
#  updated_at :datetime
#

class SprintDetailSequence < ActiveRecord::Base
end
