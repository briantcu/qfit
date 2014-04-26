# == Schema Information
#
# Table name: tips
#
#  id            :integer          not null, primary key
#  exercise_type :integer
#  tip           :text
#  exercise_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Tip < ActiveRecord::Base
end
