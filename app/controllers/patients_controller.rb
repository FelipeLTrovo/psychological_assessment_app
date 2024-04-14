class PatientsController < ApplicationController
  before_action :authenticate_psychologist!
  before_action :set_patient, only: %i[ show edit update destroy ]

  def index
    @patients = Patient.all
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def edit
  end

  def create
    @form = PatientForm.new(patient_params)
    @patient = @form.save

    if @patient.save
      redirect_to patient_url(@patient), notice: "Patient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @form = PatientForm.new(patient_params.merge(id: params[:id])).update

    if @patient
      redirect_to patient_url(@patient), notice: "Patient was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy!

    redirect_to patients_url, notice: "Patient was successfully destroyed."
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.permit(:name, :email, :cpf, :birthdate)
  end
end
