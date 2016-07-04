# == Schema Information
#
# Table name: plyometrics
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  video_link  :string(255)
#  recommended :text
#  created_at  :datetime
#  updated_at  :datetime
#  paid_tier   :integer          default(1)
#

class Plyometric < ActiveRecord::Base

  def tips
    Tip.for_exercise(3, id)
  end

  def as_json(options={})
    super(:include =>[:tips])
  end
end
