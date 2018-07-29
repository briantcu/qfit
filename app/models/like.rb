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
  belongs_to :liker, foreign_key: :liker, class_name: 'User'
  belongs_to :message
end
