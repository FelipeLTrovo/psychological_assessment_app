class InstrumentsSolverController < ApplicationController
  before_action :set_instrument_application, :validate_application_status, only: %i[index new create]
  before_action :set_patient, :validate_patient_access, only: %i[index new]

  def index
    #@patient = Patient.find(params[:patient_id])
  end

  def new
    InstrumentsSolverService.new(application: @application).call
  end

  def create
    #@instrument = Instrument.find(params[:instrument_id])
    InstrumentsSolverService.new(application: @application, answer_points: answers_points_params).call
    redirect_to instruments_solver_path(@application), notice: "Instrument application has been successfully submitted."
  end

  private

  def set_instrument_application
    @application = InstrumentApplication.find(params[:application])
  end

  def validate_application_status
    redirect_to root_path and return if @application.finished?
  end

  def set_patient
    @patient = @application.patient
  end

  def validate_patient_access
    redirect_to root_path and return unless @patient.secure_token == params[:access]
  end

  def answers_points_params
    params.permit(:question_1_answer, :question_2_answer, :question_3_answer, :question_4_answer, :question_5_answer)
  end
end