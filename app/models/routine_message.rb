class RoutineMessage < ActiveRecord::Base
  belongs_to :daily_routine, dependent: :destroy
end
