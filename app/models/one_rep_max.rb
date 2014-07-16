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

  def self.get_max(num_reps, weight)
    if num_reps > 20
      percentage = 0.3
    else
      one_rep_max = OneRepMax.where(rep: num_reps).first
      percentage = one_rep_max.percentage
    end

    max = weight / percentage
    max.to_i
  end

  def self.get_weight(num_reps, max)
    if num_reps > 20
      percentage = 0.3
    else
      one_rep_max = OneRepMax.where(rep: num_reps).first
      percentage = one_rep_max.percentage
    end

    weight = max * percentage
    weight.to_i
  end
end
