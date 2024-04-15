require 'rails_helper'

describe '#new' do
  it 'should send the instrument to a patient' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )

    login_as(psychologist)

    visit "/instruments_applier/new?patient_id=#{patient.id}"
    
    find(:select, 'instrument_id').first(:option, instrument.name).select_option

    click_button 'Send instrument'

    expect(page).to have_content('Instrument was successfully sent.')
  end
end