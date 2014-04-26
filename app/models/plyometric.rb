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
#

class Plyometric < ActiveRecord::Base
end
