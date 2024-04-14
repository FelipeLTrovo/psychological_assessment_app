require 'rails_helper'

RSpec.describe InstrumentsApplierService, type: :model do

  describe '#call' do
    before :all do
      @patient = Patient.create(name: 'John Doe', 
                                email: 'john.doe@email.com', 
                                cpf: '123456789-0',
                                birthdate: Date.today
                               )

      @question = Question.new
      @question.text = 'My question'
      4.times do 
        @question.answers << Answer.new(text: 'My answer', points: 2)
      end
      @question.save     

      @instrument = Instrument.new
      @instrument.name = 'My instrument'
      5.times do 
        @instrument.questions << @question
      end
      @instrument.save

      @psychologist = Psychologist.create(email: 'test@test.com', password: '123456')
    end

    it 'should create an InstrumentApplication' do
      expect { InstrumentsApplierService.new(patient: @patient,
                                             psychologist: @psychologist,
                                             instrument: @instrument).call }.to change { InstrumentApplication.count }.by(1)
    end

    it 'should send an email to the patient' do
      expect { InstrumentsApplierService.new(patient: @patient,
                                             psychologist: @psychologist,
                                             instrument: @instrument).call }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
