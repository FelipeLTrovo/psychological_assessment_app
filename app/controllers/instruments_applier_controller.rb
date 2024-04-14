class InstrumentsApplierController < ApplicationController
  before_action :set_patient, only: %i[new create]

  def new
  end

  def create
    @instrument = Instrument.find(params[:instrument_id])
    InstrumentsApplierService.new(patient: @patient, instrument: @instrument, psychologist: current_psychologist).call
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end
end