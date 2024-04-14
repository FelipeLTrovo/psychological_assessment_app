class QuestionForm
  include ActiveModel::Model

  attr_accessor :text, :answer_1, :answer_2, :answer_3, :answer_4, :id

  validates :text, presence: true
  validates :answer_1, presence: true
  validates :answer_2, presence: true
  validates :answer_3, presence: true
  validates :answer_4, presence: true

  def save
    return false if invalid?

    question = Question.create(text: text)
    question.answers << Answer.create(text: answer_1, points: 3)
    question.answers << Answer.create(text: answer_2, points: 2)
    question.answers << Answer.create(text: answer_3, points: 1)
    question.answers << Answer.create(text: answer_4, points: 0)
    question
  end

  def update
    return false if invalid?

    question = Question.find(id)
    question.update(text: text)
    question.answers[0].update(text: answer_1)
    question.answers[1].update(text: answer_2)
    question.answers[2].update(text: answer_3)
    question.answers[3].update(text: answer_4)
    question
  end
end