# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  poster_id    :integer
#  message      :text
#  parent_id    :integer
#  to_id        :integer
#  message_type :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Message < ActiveRecord::Base
  # Types:
  # 1 - Post to feed
  # 2 - DM
  # 3 - Automated completed workout to feed
  # 4 - Like notification
  # 5 - Workout Comment
  # 6 - Workout comment notification
  # 7 - Goal Completed

  has_many :likes
  has_many :likers, through: :likes, class_name: 'User'
  belongs_to :poster, foreign_key: :poster_id, class_name: 'User'
  belongs_to :receiver, foreign_key: :to_id, class_name: 'User'
  scope :dms, -> {where(message_type: 2)}

  def self.conversation(id_one, id_two)
    Message.dms.where('poster_id IN (?, ?) OR to_id IN (?, ?)', id_one, id_two, id_one, id_two).order(created_at: :desc).limit(20).to_a
  end
end
