class InstrumentsApplierController < ApplicationController
  before_action :authenticate_psychologist!
  before_action :set_patient, only: %i[new create]

  def new
  end

  def create
    @instrument = Instrument.find(params[:instrument_id])
    if InstrumentsApplierService.new(patient: @patient, instrument: @instrument, psychologist: current_psychologist).call
      redirect_to new_instruments_applier_path(@patient), notice: "Instrument was successfully sent."
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end
end