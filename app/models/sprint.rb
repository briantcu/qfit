# == Schema Information
#
# Table name: sprints
#
#  id          :integer          not null, primary key
#  difficulty  :integer
#  name        :string(255)
#  sprint_type :integer
#  num_laps    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Sprint < ActiveRecord::Base
  has_many :performed_sprints
end
