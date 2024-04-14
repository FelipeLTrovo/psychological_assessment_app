require 'rails_helper'

RSpec.describe InstrumentForm, type: :model do
  before :all do
    @question = Question.new
    @question.text = 'My question'
    4.times do 
      @question.answers << Answer.new(text: 'My answer', points: 2)
    end
    @question.save
  end
  
  context 'with valid params' do
    describe '#save' do
      params = {
                 name: 'My instrument',
                 question_1: 1,
                 question_2: 2,
                 question_3: 3,
                 question_4: 4,
                 question_5: 5
               }

      it 'should create an instrument' do
        expect { InstrumentForm.new(params).save }.to change { Instrument.count }.by(1)
      end
    end

    describe '#update' do
      params = {
                   name: 'My instrument',
                   question_1: 1,
                   question_2: 2,
                   question_3: 3,
                   question_4: 4,
                   question_5: 5
                }
      updated_params = {
                          name: 'My updated instrument',
                          question_1: 5,
                          question_2: 4,
                          question_3: 2,
                          question_4: 3,
                          question_5: 1
                       }
      
      it 'should update an instrument' do
        instrument = InstrumentForm.new(params).save

        InstrumentForm.new(updated_params.merge(id: instrument.id)).update
        instrument.reload

        expect(instrument.name).to eq('My updated instrument')
        expect(instrument.questions[0].id).to eq(5)
        expect(instrument.questions[1].id).to eq(4)
        expect(instrument.questions[2].id).to eq(2)
        expect(instrument.questions[3].id).to eq(3)
        expect(instrument.questions[4].id).to eq(1)
      end
    end
  end

  context 'with invalid params' do
    describe '#save' do
      params = {
                 name: '',
                 question_1: 1,
                 question_2: 2,
                 question_3: 3,
                 question_4: 4,
                 question_5: 5
               }

      it 'should not create an instrument' do
        expect { InstrumentForm.new(params).save }.to change { Instrument.count }.by(0)
      end
    end

    describe '#update' do
      params = {
                   name: 'My instrument',
                   question_1: 1,
                   question_2: 2,
                   question_3: 3,
                   question_4: 4,
                   question_5: 5
                }
      updated_params = {
                          name: '',
                          question_1: 5,
                          question_2: 4,
                          question_3: 2,
                          question_4: 3,
                          question_5: 1
                       }
      
      it 'should not update an instrument' do
        instrument = InstrumentForm.new(params).save

        InstrumentForm.new(updated_params.merge(id: instrument.id)).update
        instrument.reload

        expect(instrument.name).to eq('My instrument')
        expect(instrument.questions[0].id).to_not eq(5)
        expect(instrument.questions[1].id).to_not eq(4)
        expect(instrument.questions[2].id).to_not eq(2)
        expect(instrument.questions[3].id).to_not eq(3)
        expect(instrument.questions[4].id).to_not eq(1)
      end
    end
  end
end
