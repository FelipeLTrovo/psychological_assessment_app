require 'rails_helper'

describe '#index' do
  it 'should list the patients in the index page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patients_path

    expect(page).to have_content(patient.name)
    expect(page).to have_content(patient.email)
    expect(page).to have_content(patient.cpf)
    expect(page).to have_content(patient.birthdate)
  end

  it 'should take the user to Patient show page if user clicks Show button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patients_path

    find("#show_patient_#{patient.id}").click

    expect(current_path).to eq(patient_path(patient.id))
    expect(page).to have_content(patient.name)
    expect(page).to have_content(patient.email)
    expect(page).to have_content(patient.cpf)
    expect(page).to have_content(patient.birthdate)
  end

  it 'should take the user to Patient edit page if user clicks Edit button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patients_path

    find("#edit_patient_#{patient.id}").click

    expect(current_path).to eq(edit_patient_path(patient.id))
    expect(page).to have_content('Editing a patient')
  end

  it 'should take the user to Send Instrument page if user clicks Send... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patients_path

    find("#send_patient_#{patient.id}").click

    expect(current_path).to eq(new_instruments_applier_path)
    expect(page).to have_content("Send an instrument to #{patient.name}")
  end

  it 'should delete the patient when the user clicks Delete button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patients_path

    find("#delete_patient_#{patient.id}").click

    expect(current_path).to eq(patients_path)
    expect(page).to have_content('Patient was successfully destroyed.')
  end

  
end

describe '#show' do
  it 'should display the patient data in the show page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patient_path(patient.id)

    expect(page).to have_content(patient.name)
    expect(page).to have_content(patient.email)
    expect(page).to have_content(patient.cpf)
    expect(page).to have_content(patient.birthdate)
  end

  it 'should take the user to Patient index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patient_path(patient.id)

    click_link 'Back to Patients'

    expect(current_path).to eq(patients_path)
    expect(page).to have_content(patient.name)
    expect(page).to have_content(patient.email)
    expect(page).to have_content(patient.cpf)
    expect(page).to have_content(patient.birthdate)
  end

  it 'should take the user to Patient edit page if user clicks Edit button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patient_path(patient.id)

    click_link 'Edit'

    expect(current_path).to eq(edit_patient_path(patient.id))
    expect(page).to have_content('Editing a patient')
  end

  it 'should take the user to Send Instrument page if user clicks Send... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patient_path(patient.id)

    click_link 'Send an instrument to this patient'

    expect(current_path).to eq(new_instruments_applier_path)
    expect(page).to have_content("Send an instrument to #{patient.name}")
  end

  it 'should delete the patient when the user clicks Delete button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit patient_path(patient.id)

    click_button 'Delete'

    expect(current_path).to eq(patients_path)
    expect(page).to have_content('Patient was successfully destroyed.')
  end
end

describe '#edit' do
  it 'should take the user to Patient index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    patient = Patient.create(
                              name: 'Test patient',
                              email: 'patient@test.com',
                              cpf: '432523525-34',
                              birthdate: Date.today
                            )
    login_as(psychologist)

    visit edit_patient_path(patient.id)

    find('#back_button').click

    expect(current_path).to eq(patients_path)
    expect(page).to have_content(patient.name)
    expect(page).to have_content(patient.email)
    expect(page).to have_content(patient.cpf)
    expect(page).to have_content(patient.birthdate)
  end
end

describe '#new' do
  it 'should fill in the form and create a patient and display his show page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')

    login_as(psychologist)

    visit new_patient_path
    
    fill_in 'name', with: 'Test patient'
    fill_in 'email', with: 'patient@test.com'
    fill_in 'cpf', with: '23324563-98'
    fill_in 'birthdate', with: Date.yesterday
    
    click_button 'Add patient'

    expect(current_path).to eq(patient_path(Patient.last))
    expect(page).to have_content('Patient was successfully created.')
    expect(page).to have_content('Test patient')
    expect(page).to have_content('patient@test.com')
    expect(page).to have_content('23324563-98')
    expect(page).to have_content(Date.yesterday)
  end

  it 'should take the user to Patient index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')

    login_as(psychologist)

    visit new_patient_path

    click_link 'Back to patients'

    expect(current_path).to eq(patients_path)

  end
end