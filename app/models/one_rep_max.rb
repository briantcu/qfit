# == Schema Information
#
# Table name: one_rep_maxes
#
#  id         :integer          not null, primary key
#  rep        :integer
#  percentage :float
#  created_at :datetime
#  updated_at :datetime
#

class OneRepMax < ActiveRecord::Base
end
