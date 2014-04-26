class SprintDetailSequencesController < ApplicationController
  before_action :set_sprint_detail_sequence, only: [:show, :edit, :update, :destroy]

  # GET /sprint_detail_sequences
  # GET /sprint_detail_sequences.json
  def index
    @sprint_detail_sequences = SprintDetailSequence.all
  end

  # GET /sprint_detail_sequences/1
  # GET /sprint_detail_sequences/1.json
  def show
  end

  # GET /sprint_detail_sequences/new
  def new
    @sprint_detail_sequence = SprintDetailSequence.new
  end

  # GET /sprint_detail_sequences/1/edit
  def edit
  end

  # POST /sprint_detail_sequences
  # POST /sprint_detail_sequences.json
  def create
    @sprint_detail_sequence = SprintDetailSequence.new(sprint_detail_sequence_params)

    respond_to do |format|
      if @sprint_detail_sequence.save
        format.html { redirect_to @sprint_detail_sequence, notice: 'Sprint detail sequence was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sprint_detail_sequence }
      else
        format.html { render action: 'new' }
        format.json { render json: @sprint_detail_sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sprint_detail_sequences/1
  # PATCH/PUT /sprint_detail_sequences/1.json
  def update
    respond_to do |format|
      if @sprint_detail_sequence.update(sprint_detail_sequence_params)
        format.html { redirect_to @sprint_detail_sequence, notice: 'Sprint detail sequence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sprint_detail_sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sprint_detail_sequences/1
  # DELETE /sprint_detail_sequences/1.json
  def destroy
    @sprint_detail_sequence.destroy
    respond_to do |format|
      format.html { redirect_to sprint_detail_sequences_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sprint_detail_sequence
      @sprint_detail_sequence = SprintDetailSequence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sprint_detail_sequence_params
      params.require(:sprint_detail_sequence).permit(:sprint_id, :detail_num, :order_num)
    end
end
