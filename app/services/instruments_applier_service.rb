class InstrumentsApplierService
  include Rails.application.routes.url_helpers

  def initialize(patient:, instrument:, psychologist:)
    @patient = patient
    @instrument = instrument
    @psychologist = psychologist
    @application = nil
  end

  def call
    create_instrument_application
    send_email
  end

  private

  def create_instrument_application
    @application = InstrumentApplication.create(instrument: @instrument, patient: @patient, psychologist: @psychologist)
  end

  def generate_url
    "#{instruments_solver_index_url}?application=#{@application.id}&access=#{@patient.secure_token}"
  end

  def send_email
    InstrumentsMailer.apply_instrument_email(recipient: @patient.email, url: generate_url).deliver!
  end
end