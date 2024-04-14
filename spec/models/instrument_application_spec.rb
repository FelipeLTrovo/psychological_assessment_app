require 'rails_helper'

RSpec.describe InstrumentApplication, type: :model do

  it 'should create an instrument_application' do
    expect { InstrumentApplication.create(patient: Patient.new,
                                          instrument: Instrument.new,
                                          psychologist: Psychologist.new) }.to change { InstrumentApplication.count }.by(1)
  end

  it 'should set status as pending after an instrument_application is created' do
    application = InstrumentApplication.create(patient: Patient.new,
                                               instrument: Instrument.new,
                                               psychologist: Psychologist.new)

    expect(application.status).to eq('pending')
  end
end
