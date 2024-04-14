require 'rails_helper'

RSpec.describe Question, type: :model do

  it 'should create a question' do
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end

    expect { question.save }.to change { Question.count }.by(1)
  end

  it 'should not create a question without text' do
    question = Question.new
    question.text = ''
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end

    expect { question.save }.to change { Question.count }.by(0)
  end

  it 'should not create a question with less than 4 answers' do
    question = Question.new
    question.text = 'My question'
    3.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end

    expect { question.save }.to change { Question.count }.by(0)
  end
end
