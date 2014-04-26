# == Schema Information
#
# Table name: exercises
#
#  id             :integer          not null, primary key
#  type           :integer
#  video_link     :string(255)
#  look_up_value  :integer
#  percent_of_luv :float
#  category       :integer
#  difficulty     :integer
#  is_body_weight :boolean
#  name           :string(255)
#  is_image       :boolean
#  created_at     :datetime
#  updated_at     :datetime
#

class Exercise < ActiveRecord::Base
end
