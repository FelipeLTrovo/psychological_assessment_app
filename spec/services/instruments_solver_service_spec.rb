require 'rails_helper'

RSpec.describe InstrumentsSolverService, type: :model do
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

    @application = InstrumentApplication.create(patient: @patient, instrument: @instrument, psychologist: @psychologist) 
  end

  context 'without answer_points parameters' do
    describe '#call' do
      it 'should change the status of the InstrumentApplication to in_progress' do
        InstrumentsSolverService.new(application: @application).call

        expect(@application.status).to eq('in_progress')
      end
    end
  end

  context 'with answer_points parameters' do
    describe '#call' do
      it 'should change the status of the InstrumentApplication to finished' do
        InstrumentsSolverService.new(application: @application, answer_points: {
                                                                                question_1_answer: '3',
                                                                                question_2_answer: '3',
                                                                                question_3_answer: '3',
                                                                                question_4_answer: '3',
                                                                                question_5_answer: '3'
                                                                               }).call

        expect(@application.status).to eq('finished')
      end

      it 'should persist the total score of the InstrumentApplication' do
        InstrumentsSolverService.new(application: @application, answer_points: {
                                                                                question_1_answer: '3',
                                                                                question_2_answer: '3',
                                                                                question_3_answer: '3',
                                                                                question_4_answer: '3',
                                                                                question_5_answer: '3'
                                                                               }).call

        expect(@application.score).to eq(15)
      end
    end
  end

  context 'when the application is already finished' do
    describe '#call' do
      it 'should escape and return nil' do
        expect(InstrumentsSolverService.new(application: @application, answer_points: {
                                                                                       question_1_answer: '3',
                                                                                       question_2_answer: '3',
                                                                                       question_3_answer: '3',
                                                                                       question_4_answer: '3',
                                                                                       question_5_answer: '3'
                                                                                      }).call).to eq(nil)

      end
    end
  end
end
