# == Schema Information
#
# Table name: exercises
#
#  id               :integer          not null, primary key
#  exercise_type_id :integer
#  video_link       :string(255)
#  look_up_value    :integer
#  percent_of_luv   :float
#  category         :integer
#  difficulty       :integer
#  is_body_weight   :boolean
#  name             :string(255)
#  is_image         :boolean
#  created_at       :datetime
#  updated_at       :datetime
#  paid_tier        :integer          default(1)
#  for_time         :boolean
#  thumbnail        :string
#

class Exercise < ActiveRecord::Base
  belongs_to :exercise_type, :foreign_key => :exercise_type_id

  def tips
    Tip.for_exercise(2, id)
  end

  def as_json(options={})
    super(:include =>[:tips])
  end
end
