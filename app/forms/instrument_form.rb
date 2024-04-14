class InstrumentForm
  include ActiveModel::Model

  attr_accessor :name, :question_1, :question_2, :question_3, :question_4, :question_5, :id

  validates :name, presence: true
  validates :question_1, presence: true
  validates :question_2, presence: true
  validates :question_3, presence: true
  validates :question_4, presence: true
  validates :question_5, presence: true

  def save
    return false if invalid?

    instrument = Instrument.new(name: name)
    instrument.questions << Question.find(question_1)
    instrument.questions << Question.find(question_2)
    instrument.questions << Question.find(question_3)
    instrument.questions << Question.find(question_4)
    instrument.questions << Question.find(question_5)
    instrument.save
    instrument
  end

  def update
    return false if invalid?

    instrument = Instrument.find(id)
    instrument.update(name: name)
    instrument.questions.destroy_all
    instrument.questions << Question.find(question_1)
    instrument.questions << Question.find(question_2)
    instrument.questions << Question.find(question_3)
    instrument.questions << Question.find(question_4)
    instrument.questions << Question.find(question_5)
    instrument.save
  end
end