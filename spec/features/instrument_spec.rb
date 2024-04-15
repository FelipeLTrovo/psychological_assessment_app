require 'rails_helper'

describe '#index' do
  it 'should list the instruments in the index page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save

    login_as(psychologist)

    visit instruments_path

    expect(page).to have_content(instrument.name)

  end

  it 'should take the user to Instrument show page if user clicks Show button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save

    login_as(psychologist)

    visit instruments_path

    find("#show_instrument_#{instrument.id}").click

    expect(current_path).to eq(instrument_path(instrument.id))
    expect(page).to have_content(instrument.name)
    expect(page).to have_content(instrument.questions[0].text)
    expect(page).to have_content(instrument.questions[1].text)
    expect(page).to have_content(instrument.questions[2].text)
    expect(page).to have_content(instrument.questions[3].text)
    expect(page).to have_content(instrument.questions[4].text)
  end

  it 'should take the user to Instrument edit page if user clicks Edit button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save

    login_as(psychologist)

    visit instruments_path

    find("#edit_instrument_#{instrument.id}").click

    expect(current_path).to eq(edit_instrument_path(instrument.id))
    expect(page).to have_content('Edit an instrument')
  end

  it 'should delete the instrument when the user clicks Delete button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save

    login_as(psychologist)

    visit instruments_path

    find("#delete_instrument_#{instrument.id}").click

    expect(current_path).to eq(instruments_path)
    expect(page).to have_content('Instrument was successfully destroyed.')
  end

  
end

describe '#show' do
  it 'should display the instrument data in the show page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save
    

    login_as(psychologist)

    visit instrument_path(instrument.id)

    expect(page).to have_content(instrument.name)
    expect(page).to have_content(instrument.questions[0].text)
    expect(page).to have_content(instrument.questions[1].text)
    expect(page).to have_content(instrument.questions[2].text)
    expect(page).to have_content(instrument.questions[3].text)
    expect(page).to have_content(instrument.questions[4].text)
  end

  it 'should take the user to Instrument index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save

    login_as(psychologist)

    visit instrument_path(instrument.id)

    click_link 'Back to Instruments'

    expect(current_path).to eq(instruments_path)
    expect(page).to have_content(instrument.name)
  end

  it 'should take the user to Instrument edit page if user clicks Edit button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit question_path(question.id)

    click_link 'Edit'

    expect(current_path).to eq(edit_question_path(question.id))
    expect(page).to have_content('Edit a question')
  end

  it 'should delete the instrument when the user clicks Delete button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save

    login_as(psychologist)

    visit instrument_path(instrument.id)

    click_button 'Delete'

    expect(current_path).to eq(instruments_path)
    expect(page).to have_content('Instrument was successfully destroyed.')
  end
end

describe '#edit' do
  it 'should take the user to Instrument index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save

    login_as(psychologist)

    visit edit_instrument_path(instrument.id)

    click_link 'Back to instruments'

    expect(current_path).to eq(instruments_path)
    expect(page).to have_content(instrument.name)
  end
end

describe '#new' do
  it 'should fill in the form and create an instrument and display its show page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = ''
    5.times do
      question = Question.new
      question.text = 'My question'
      4.times do 
        question.answers << Answer.new(text: 'My answer', points: 2)
      end
      question.save
    end
    instrument = Instrument.new
    instrument.name = 'My instrument'
    5.times do 
      instrument.questions << question
    end
    instrument.save

    login_as(psychologist)

    visit new_instrument_path
    
    fill_in 'name', with: 'New instrument'
    find(:select, 'question_1').first(:option, Question.all[0].text).select_option
    find(:select, 'question_2').first(:option, Question.all[1].text).select_option
    find(:select, 'question_3').first(:option, Question.all[2].text).select_option
    find(:select, 'question_4').first(:option, Question.all[3].text).select_option
    find(:select, 'question_5').first(:option, Question.all[4].text).select_option
    
    click_button 'Add instrument'

    expect(current_path).to eq(instrument_path(Instrument.last))
    expect(page).to have_content('Instrument was successfully created.')
    expect(page).to have_content('New instrument')
    expect(page).to have_content(Question.all[0].text)
    expect(page).to have_content(Question.all[1].text)
    expect(page).to have_content(Question.all[2].text)
    expect(page).to have_content(Question.all[3].text)
    expect(page).to have_content(Question.all[4].text)
  end

  it 'should take the user to Instrument index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')

    login_as(psychologist)

    visit new_instrument_path

    click_link 'Back to instruments'

    expect(current_path).to eq(instruments_path)
  end
end