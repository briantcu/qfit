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
#  thumbnail   :string
#

class PlyometricsController < ApplicationController

  # GET /plyometrics
  # GET /plyometrics.json
  def index
    @plyometrics = Plyometric.all
  end

end
