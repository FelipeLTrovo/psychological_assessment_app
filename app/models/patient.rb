class Patient < ApplicationRecord
  has_many :instruments

  validates :email, :cpf, uniqueness: true

  before_create :generate_secure_uuid

  private

  def generate_secure_uuid
    self.secure_token = SecureRandom.uuid
  end
end
