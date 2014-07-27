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
#

class Warmup < ActiveRecord::Base
end
