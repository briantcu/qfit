class UserMaxesController < ApplicationController
  before_action :set_user_max, only: [:show, :edit, :update, :destroy]

  # GET /user_maxes
  # GET /user_maxes.json
  def index
    @user_maxes = UserMax.all
  end

  # GET /user_maxes/1
  # GET /user_maxes/1.json
  def show
  end

  # GET /user_maxes/new
  def new
    @user_max = UserMax.new
  end

  # GET /user_maxes/1/edit
  def edit
  end

  # POST /user_maxes
  # POST /user_maxes.json
  def create
    @user_max = UserMax.new(user_max_params)

    respond_to do |format|
      if @user_max.save
        format.html { redirect_to @user_max, notice: 'User max was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_max }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_max.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_maxes/1
  # PATCH/PUT /user_maxes/1.json
  def update
    respond_to do |format|
      if @user_max.update(user_max_params)
        format.html { redirect_to @user_max, notice: 'User max was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_max.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_maxes/1
  # DELETE /user_maxes/1.json
  def destroy
    @user_max.destroy
    respond_to do |format|
      format.html { redirect_to user_maxes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_max
      @user_max = UserMax.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_max_params
      params.require(:user_max).permit(:exercise_id, :user_id, :max)
    end
end
