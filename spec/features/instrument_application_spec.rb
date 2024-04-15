require 'rails_helper'

describe '#index' do
  it 'should list the instrument applications in the index page' do
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
                                               psychologist: psychologist, score: 11)

    login_as(psychologist)

    visit instruments_applications_path

    expect(page).to have_content(application.patient.name)
    expect(page).to have_content(application.instrument.name)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.score)
    expect(page).to have_content(application.updated_at.strftime("%d/%m/%Y"))
  end

  it 'should take the user to InstrumentApplication show page if user clicks Show button' do
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
                                               psychologist: psychologist, score: 11)

    login_as(psychologist)

    visit instruments_applications_path

    find("#show_application_#{application.id}").click

    expect(current_path).to eq(instruments_application_path(application.id))
    expect(page).to have_content(application.instrument.name)
    expect(page).to have_content('Total Score:')
    expect(page).to have_content(application.score)
  end

  it 'should delete the instrument application when the user clicks Delete button' do
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
                                               psychologist: psychologist, score: 11)

    login_as(psychologist)

    visit instruments_applications_path

    find("#delete_application_#{application.id}").click

    expect(current_path).to eq(instruments_applications_path)
    expect(page).to have_content('Application was successfully destroyed.')
  end

  
end

describe '#show' do
  it 'should display the instrument application data in the show page' do
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
                                               psychologist: psychologist, score: 11)

    login_as(psychologist)

    visit instruments_application_path(application.id)

    expect(page).to have_content(application.instrument.name)
    expect(page).to have_content('Total Score:')
    expect(page).to have_content(application.score)
  end

  it 'should take the user to InstrumentApplication index page if user clicks Back... button' do
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
                                               psychologist: psychologist, score: 11)

    login_as(psychologist)

    visit instruments_application_path(application.id)

    click_link 'Back to Instrument Applications'

    expect(current_path).to eq(instruments_applications_path)
    expect(page).to have_content(application.patient.name)
    expect(page).to have_content(application.instrument.name)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.score)
    expect(page).to have_content(application.updated_at.strftime("%d/%m/%Y"))
  end

  it 'should delete the question when the user clicks Delete button' do
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
                                               psychologist: psychologist, score: 11)

    login_as(psychologist)

    visit instruments_application_path(application.id)

    click_button 'Delete'

    expect(current_path).to eq(instruments_applications_path)
    expect(page).to have_content('Application was successfully destroyed.')
  end
end