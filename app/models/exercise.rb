class Exercise < ActiveRecord::Base
  belongs_to :exercise_type, :foreign_key => :exercise_type_id
end
