require 'rails_helper'

RSpec.describe PatientForm, type: :model do

  context 'with valid params' do
    describe '#save' do
      params = {
                 name: 'John Doe',
                 email: 'john.doe@gmail.com',
                 cpf: '987654321-0',
                 birthdate: Date.today
               }

      it 'should create a patient' do
        expect { PatientForm.new(params).save }.to change { Patient.count }.by(1)
      end
    end

    describe '#update' do
      params = {
                   name: 'John Doe',
                   email: 'john.doe@gmail.com',
                   cpf: '987654321-0',
                   birthdate: Date.today
                }
      updated_params = {
                          name: 'Jane Doe',
                          email: 'jane.doe@gmail.com',
                          cpf: '187652257-3',
                          birthdate: Date.yesterday
                       }
      
      it 'should update a patient' do
        patient = PatientForm.new(params).save

        PatientForm.new(updated_params.merge(id: patient.id)).update
        patient.reload

        expect(patient.name).to eq('Jane Doe')
        expect(patient.email).to eq('jane.doe@gmail.com')
        expect(patient.cpf).to eq('187652257-3')
        expect(patient.birthdate).to eq(Date.yesterday)
      end
    end
  end

  context 'with invalid params' do
    describe '#save' do
      params = {
                 name: '',
                 email: 'john.doe@gmail.com',
                 cpf: '987654321-0',
                 birthdate: Date.today
               }

      it 'should not create a patient' do
        expect { PatientForm.new(params).save }.to change { Patient.count }.by(0)
      end
    end

    describe '#update' do
      params = {
                   name: 'John Doe',
                   email: 'john.doe@gmail.com',
                   cpf: '987654321-0',
                   birthdate: Date.today
                }
      updated_params = {
                          name: '',
                          email: 'jane.doe@gmail.com',
                          cpf: '187652257-3',
                          birthdate: Date.yesterday
                       }
      
      it 'should not update a patient' do
        patient = PatientForm.new(params).save

        PatientForm.new(updated_params.merge(id: patient.id)).update
        patient.reload

        expect(patient.name).to eq('John Doe')
        expect(patient.email).to_not eq('jane.doe@gmail.com')
        expect(patient.cpf).to_not eq('187652257-3')
        expect(patient.birthdate).to_not eq(Date.yesterday)
      end
    end
  end
end
