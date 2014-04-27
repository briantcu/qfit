# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  poster_id  :integer
#  message    :text
#  parent_id  :integer
#  to_id      :integer
#  type       :integer
#  created_at :datetime
#  updated_at :datetime
#

class Message < ActiveRecord::Base
  has_many :likes
  belongs_to :user, :foreign_key => :poster_id
  belongs_to :user, :foreign_key => :to_id
end
