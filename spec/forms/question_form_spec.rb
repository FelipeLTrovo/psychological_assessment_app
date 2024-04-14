require 'rails_helper'

RSpec.describe QuestionForm, type: :model do

  context 'with valid params' do
    describe '#save' do
      params = {
                 text: 'My question',
                 answer_1: 'My answer1',
                 answer_2: 'My answer2',
                 answer_3: 'My answer3',
                 answer_4: 'My answer4'
               }

      it 'should create a question' do
        expect { QuestionForm.new(params).save }.to change { Question.count }.by(1)
      end
    end

    describe '#update' do
      params = {
                   text: 'My question',
                   answer_1: 'My answer1',
                   answer_2: 'My answer2',
                   answer_3: 'My answer3',
                   answer_4: 'My answer4'
                }
      updated_params = {
                          text: 'My updated question',
                          answer_1: 'My updated answer1',
                          answer_2: 'My updated answer2',
                          answer_3: 'My updated answer3',
                          answer_4: 'My updated answer4'
                       }
      
      it 'should update a question' do
        question = QuestionForm.new(params).save

        QuestionForm.new(updated_params.merge(id: question.id)).update
        question.reload

        expect(question.text).to eq('My updated question')
        expect(question.answers[0].text).to eq('My updated answer1')
        expect(question.answers[1].text).to eq('My updated answer2')
        expect(question.answers[2].text).to eq('My updated answer3')
        expect(question.answers[3].text).to eq('My updated answer4')
      end
    end
  end

  context 'with invalid params' do
    describe '#save' do
      params = {
                 text: '',
                 answer_1: 'My answer1',
                 answer_2: 'My answer2',
                 answer_3: 'My answer3',
                 answer_4: 'My answer4'
               }

      it 'should not create a question' do
        expect { QuestionForm.new(params).save }.to change { Question.count }.by(0)
      end
    end

    describe '#update' do
      params = {
                   text: 'My question',
                   answer_1: 'My answer1',
                   answer_2: 'My answer2',
                   answer_3: 'My answer3',
                   answer_4: 'My answer4'
                }
      updated_params = {
                          text: '',
                          answer_1: 'My updated answer1',
                          answer_2: 'My updated answer2',
                          answer_3: 'My updated answer3',
                          answer_4: 'My updated answer4'
                       }
      
      it 'should update a question' do
        question = QuestionForm.new(params).save

        QuestionForm.new(updated_params.merge(id: question.id)).update
        question.reload

        expect(question.text).to eq('My question')
        expect(question.answers[0].text).to_not eq('My updated answer1')
        expect(question.answers[1].text).to_not eq('My updated answer2')
        expect(question.answers[2].text).to_not eq('My updated answer3')
        expect(question.answers[3].text).to_not eq('My updated answer4')
      end
    end
  end
end
