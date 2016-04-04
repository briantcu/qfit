class SprintDetailSequence < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :sprint_detail
end
