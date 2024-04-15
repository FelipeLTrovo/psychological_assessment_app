require 'rails_helper'

describe '#index' do
  it 'should list the questions in the index page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit questions_path

    expect(page).to have_content(question.text)

  end

  it 'should take the user to Question show page if user clicks Show button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit questions_path

    find("#show_question_#{question.id}").click

    expect(current_path).to eq(question_path(question.id))
    expect(page).to have_content(question.text)
    expect(page).to have_content(question.answers[0].text)
    expect(page).to have_content(question.answers[1].text)
    expect(page).to have_content(question.answers[2].text)
    expect(page).to have_content(question.answers[3].text)
  end

  it 'should take the user to Question edit page if user clicks Edit button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit questions_path

    find("#edit_question_#{question.id}").click

    expect(current_path).to eq(edit_question_path(question.id))
    expect(page).to have_content('Edit a question')
  end

  it 'should delete the question when the user clicks Delete button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit questions_path

    find("#delete_question_#{question.id}").click

    expect(current_path).to eq(questions_path)
    expect(page).to have_content('Question was successfully destroyed.')
  end

  
end

describe '#show' do
  it 'should display the question data in the show page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit question_path(question.id)

    expect(page).to have_content(question.text)
    expect(page).to have_content(question.answers[0].text)
    expect(page).to have_content(question.answers[1].text)
    expect(page).to have_content(question.answers[2].text)
    expect(page).to have_content(question.answers[3].text)
  end

  it 'should take the user to Question index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit question_path(question.id)

    click_link 'Back to Questions'

    expect(current_path).to eq(questions_path)
    expect(page).to have_content(question.text)
  end

  it 'should take the user to Question edit page if user clicks Edit button' do
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

  it 'should delete the question when the user clicks Delete button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit question_path(question.id)

    click_button 'Delete'

    expect(current_path).to eq(questions_path)
    expect(page).to have_content('Question was successfully destroyed.')
  end
end

describe '#edit' do
  it 'should take the user to Question index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')
    question = Question.new
    question.text = 'My question'
    4.times do 
      question.answers << Answer.new(text: 'My answer', points: 2)
    end
    question.save

    login_as(psychologist)

    visit edit_question_path(question.id)

    click_link 'Back to questions'

    expect(current_path).to eq(questions_path)
    expect(page).to have_content(question.text)
  end
end

describe '#new' do
  it 'should fill in the form and create a question and display its show page' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')

    login_as(psychologist)

    visit new_question_path
    
    fill_in 'text', with: 'New question'
    fill_in 'answer_1', with: Answer.all[0].text
    fill_in 'answer_2', with: Answer.all[1].text
    fill_in 'answer_3', with: Answer.all[2].text
    fill_in 'answer_4', with: Answer.all[3].text

    
    click_button 'Add question'

    expect(current_path).to eq(question_path(Question.last))
    expect(page).to have_content('Question was successfully created.')
    expect(page).to have_content('New question')
    expect(page).to have_content(Answer.all[0].text)
    expect(page).to have_content(Answer.all[1].text)
    expect(page).to have_content(Answer.all[2].text)
    expect(page).to have_content(Answer.all[3].text)
  end

  it 'should take the user to Question index page if user clicks Back... button' do
    psychologist = Psychologist.create(email: 'doctor@test.com', password: '123456')

    login_as(psychologist)

    visit new_question_path

    click_link 'Back to questions'

    expect(current_path).to eq(questions_path)
  end
end