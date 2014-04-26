class ProgramDaySequencesController < ApplicationController
  before_action :set_program_day_sequence, only: [:show, :edit, :update, :destroy]

  # GET /program_day_sequences
  # GET /program_day_sequences.json
  def index
    @program_day_sequences = ProgramDaySequence.all
  end

  # GET /program_day_sequences/1
  # GET /program_day_sequences/1.json
  def show
  end

  # GET /program_day_sequences/new
  def new
    @program_day_sequence = ProgramDaySequence.new
  end

  # GET /program_day_sequences/1/edit
  def edit
  end

  # POST /program_day_sequences
  # POST /program_day_sequences.json
  def create
    @program_day_sequence = ProgramDaySequence.new(program_day_sequence_params)

    respond_to do |format|
      if @program_day_sequence.save
        format.html { redirect_to @program_day_sequence, notice: 'Program day sequence was successfully created.' }
        format.json { render action: 'show', status: :created, location: @program_day_sequence }
      else
        format.html { render action: 'new' }
        format.json { render json: @program_day_sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_day_sequences/1
  # PATCH/PUT /program_day_sequences/1.json
  def update
    respond_to do |format|
      if @program_day_sequence.update(program_day_sequence_params)
        format.html { redirect_to @program_day_sequence, notice: 'Program day sequence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @program_day_sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_day_sequences/1
  # DELETE /program_day_sequences/1.json
  def destroy
    @program_day_sequence.destroy
    respond_to do |format|
      format.html { redirect_to program_day_sequences_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_day_sequence
      @program_day_sequence = ProgramDaySequence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_day_sequence_params
      params.require(:program_day_sequence).permit(:program_id, :number_of_days, :one, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten)
    end
end
