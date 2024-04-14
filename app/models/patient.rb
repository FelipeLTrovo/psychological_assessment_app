class Patient < ApplicationRecord
  has_many :instrument_applications

  validates :name, :email, :cpf, :birthdate, presence: true
  validates :email, :cpf, uniqueness: true

  before_create :generate_secure_uuid

  private

  def generate_secure_uuid
    self.secure_token = SecureRandom.uuid
  end
end
