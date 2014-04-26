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
end
