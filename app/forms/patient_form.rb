class PatientForm
  include ActiveModel::Model

  attr_accessor :name, :email, :cpf, :birthdate, :id

  validates :name, presence: true
  validates :email, presence: true
  validates :cpf, presence: true
  validates :birthdate, presence: true


  def save
    return false if invalid?
    
    Patient.create(name: name, email: email, cpf: cpf, birthdate: birthdate)
  end

  def update
    return false if invalid?

    patient = Patient.find(id)
    patient.update(name: name, email: email, cpf: cpf, birthdate: birthdate)
  end
end