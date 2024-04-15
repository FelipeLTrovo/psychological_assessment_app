psychologist = Psychologist.create(email: 'admin@admin.com', password: '123456')

5.times do |i|
  question = Question.new(text: "Sample Question_#{i}")
  4.times do |j| 
    question.answers << Answer.new(text: "Sample Answer_#{j}", points: ((j - 3) * -1))
  end
  question.save
end

instrument = Instrument.new
instrument.name = 'Sample Instrument'
5.times do |index|
  instrument.questions << Question.all[(index)]
end
instrument.save

patient = Patient.create(
                          name: 'John Doe',
                          email: 'john.doe@test.com',
                          cpf: '432523525-34',
                          birthdate: Date.today
                        )

application = InstrumentApplication.create(patient: patient,
                                           instrument: instrument,
                                           psychologist: psychologist, score: 11, status: 'finished')
