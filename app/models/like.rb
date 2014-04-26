# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  liker      :integer
#  message_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Like < ActiveRecord::Base
end
