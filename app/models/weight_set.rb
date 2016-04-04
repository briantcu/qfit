class WeightSet < ActiveRecord::Base
  belongs_to :performed_exercise, dependent: :destroy
end
