# == Schema Information
#
# Table name: group_joins
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupJoin < ActiveRecord::Base
  belongs_to :group
  belongs_to :member, class_name: "User", foreign_key: :user_id
  validates :user_id, uniqueness: { scope: :group_id }
end
