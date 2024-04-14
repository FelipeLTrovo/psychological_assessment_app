require 'rails_helper'

RSpec.describe Answer, type: :model do
  before :all do
    @question = Question.new
  end

  it 'should create an answer' do
    expect { Answer.create(text: 'My answer', points: 3, question: @question)}.to change { Answer.count }.by(1)
  end

  it 'should not create an answer without text' do
    expect { Answer.create(text: '', points: 3, question: @question)}.to change { Answer.count }.by(0)
  end

  it 'should not create an answer without points' do
    expect { Answer.create(text: 'My answer', points: '', question: @question)}.to change { Answer.count }.by(0)
  end
end
