# == Schema Information
#
# Table name: warmups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  is_stretch :boolean
#  video_link :string(255)
#  created_at :datetime
#  updated_at :datetime
#  ex_type    :integer
#  thumbnail  :string
#  paid_tier  :integer
#

class Warmup < ActiveRecord::Base

  def tips
    Tip.for_exercise(1, id)
  end

  def as_json(options={})
    super(:include =>[:tips])
  end
end
