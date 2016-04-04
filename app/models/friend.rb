# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  id_one     :integer
#  id_two     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Friend < ActiveRecord::Base
end
