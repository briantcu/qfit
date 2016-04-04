class PlyometricsController < ApplicationController

  # GET /plyometrics
  # GET /plyometrics.json
  def index
    @plyometrics = Plyometric.all
  end

end
