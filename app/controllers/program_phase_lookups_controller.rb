class ProgramPhaseLookupsController < ApplicationController
  before_action :set_program_phase_lookup, only: [:show, :edit, :update, :destroy]

  # GET /program_phase_lookups
  # GET /program_phase_lookups.json
  def index
    @program_phase_lookups = ProgramPhaseLookup.all
  end

  # GET /program_phase_lookups/1
  # GET /program_phase_lookups/1.json
  def show
  end

  # GET /program_phase_lookups/new
  def new
    @program_phase_lookup = ProgramPhaseLookup.new
  end

  # GET /program_phase_lookups/1/edit
  def edit
  end

  # POST /program_phase_lookups
  # POST /program_phase_lookups.json
  def create
    @program_phase_lookup = ProgramPhaseLookup.new(program_phase_lookup_params)

    respond_to do |format|
      if @program_phase_lookup.save
        format.html { redirect_to @program_phase_lookup, notice: 'Program phase lookup was successfully created.' }
        format.json { render action: 'show', status: :created, location: @program_phase_lookup }
      else
        format.html { render action: 'new' }
        format.json { render json: @program_phase_lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_phase_lookups/1
  # PATCH/PUT /program_phase_lookups/1.json
  def update
    respond_to do |format|
      if @program_phase_lookup.update(program_phase_lookup_params)
        format.html { redirect_to @program_phase_lookup, notice: 'Program phase lookup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @program_phase_lookup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_phase_lookups/1
  # DELETE /program_phase_lookups/1.json
  def destroy
    @program_phase_lookup.destroy
    respond_to do |format|
      format.html { redirect_to program_phase_lookups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_phase_lookup
      @program_phase_lookup = ProgramPhaseLookup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_phase_lookup_params
      params.require(:program_phase_lookup).permit(:phase_number, :program_type, :phase_id)
    end
end
