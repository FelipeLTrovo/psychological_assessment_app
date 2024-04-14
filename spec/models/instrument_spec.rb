require 'rails_helper'

RSpec.describe Instrument, type: :model do
  before :all do
    @question = Question.new
    @question.text = 'My question'
    4.times do 
      @question.answers << Answer.new(text: 'My answer', points: 2)
    end
    @question.save
  end

  it 'should create an instrument' do
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << @question
    end

    expect { instrument.save }.to change { Instrument.count }.by(1)
  end

  it 'should not create an instrument without a name' do
    instrument = Instrument.new
    instrument.name = ''
    5.times do 
      instrument.questions << @question
    end

    expect { instrument.save }.to change { Instrument.count }.by(0)
  end

  it 'should not create an instrument with less than 5 questions' do
    instrument = Instrument.new
    instrument.name = 'My instrument'
    4.times do 
      instrument.questions << @question
    end

    expect { instrument.save }.to change { Instrument.count }.by(0)
  end
end
