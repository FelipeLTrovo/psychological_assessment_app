require 'rails_helper'

RSpec.describe Patient, type: :model do
  it 'should create a patient' do
    expect { Patient.create(name: 'John Doe', 
                            email: 'john.doe1@email.com', 
                            cpf: '741852963-0',
                            birthdate: Date.today
                            ) }.to change { Patient.count }.by(1)
  end

  it 'should not create a patient without name' do
    expect { Patient.create(name: '', 
                            email: 'john.doe1@email.com', 
                            cpf: '456123789-0',
                            birthdate: Date.today
                            ) }.to change { Patient.count }.by(0)
  end

  it 'should not create a patient without email' do
    expect { Patient.create(name: 'John Doe', 
                            email: '', 
                            cpf: '456123789-0',
                            birthdate: Date.today
                            ) }.to change { Patient.count }.by(0)
  end

  it 'should not create a patient without cpf' do
    expect { Patient.create(name: 'John Doe', 
                            email: 'john.doe1@email.com', 
                            cpf: '',
                            birthdate: Date.today
                            ) }.to change { Patient.count }.by(0)
  end

  it 'should not create a patient without birthdate' do
    expect { Patient.create(name: 'John Doe', 
                            email: 'john.doe1@email.com', 
                            cpf: '456123789-0',
                            birthdate: ''
                            ) }.to change { Patient.count }.by(0)
  end

  it 'should not create a patient with duplicated email' do
    Patient.create(name: 'Jane Doe', 
                   email: 'john.doe1@email.com', 
                   cpf: '987654320-1',
                   birthdate: Date.yesterday
                  ) 

    expect { Patient.create(name: 'John Doe', 
                            email: 'john.doe1@email.com', 
                            cpf: '456123789-0',
                            birthdate: Date.today
                            ) }.to change { Patient.count }.by(0)
  end

  it 'should not create a patient with duplicated cpf' do
    Patient.create(name: 'Jane Doe', 
                   email: 'jane.doe@email.com', 
                   cpf: '456123789-0',
                   birthdate: Date.yesterday
                  ) 

    expect { Patient.create(name: 'John Doe', 
                            email: 'john.doe1@email.com', 
                            cpf: '456123789-0',
                            birthdate: Date.today
                            ) }.to change { Patient.count }.by(0)
  end

  it 'should generate the secure_token after a patient is created' do
    patient = Patient.create(name: 'Jane Doe', 
                             email: 'jane.doe@email.com', 
                             cpf: '456123789-0',
                             birthdate: Date.yesterday
                            ) 
    expect(patient.secure_token.present?).to eq(true)
  end
end
