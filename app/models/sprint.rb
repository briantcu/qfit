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
  has_many :sprint_detail_sequences, -> { order :order_num }
  has_many :sprint_details, through: :sprint_detail_sequences

  def tips
    Tip.for_exercise(4, id)
  end

  def as_json(options={})
    super(:include =>[:tips])
  end
end
