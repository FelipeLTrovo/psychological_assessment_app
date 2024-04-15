require 'rails_helper'

describe '#index' do
  it 'should allow the patient to start the instrument' do
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
    application = InstrumentApplication.create(patient: patient,
                                               instrument: instrument,
                                               psychologist: psychologist)

    visit "/instruments_solver?application=#{application.id}&access=#{patient.secure_token}"
    
    fill_in 'name', with: patient.name
    fill_in 'email', with: patient.email
    fill_in 'cpf', with: patient.cpf
    fill_in 'birthdate', with: patient.birthdate

    click_button 'Next step'

    expect(current_path).to eq(new_instruments_solver_path)
    expect(page).to have_content('Solve the instrument')
  end
end

describe '#new' do
  it 'should allow the patient to take the instrument' do
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
    application = InstrumentApplication.create(patient: patient,
                                               instrument: instrument,
                                               psychologist: psychologist)

    visit "/instruments_solver/new?name=#{patient.name}&email=#{patient.email}&cpf=#{patient.cpf}&birthdate=#{patient.birthdate.to_s}&application=#{application.id}&access=#{patient.secure_token}"
    
    find(:radio_button, 'question_1_answer', match: :first)
    find(:radio_button, 'question_2_answer', match: :first)
    find(:radio_button, 'question_3_answer', match: :first)
    find(:radio_button, 'question_4_answer', match: :first)
    find(:radio_button, 'question_5_answer', match: :first)
    
    click_button 'Submit'

    expect(current_path).to eq(instruments_solver_path(application.id))
    expect(page).to have_content('Instrument application has been successfully submitted.')
    expect(page).to have_content('We will get in touch with the results. Thank you.')
  end
end