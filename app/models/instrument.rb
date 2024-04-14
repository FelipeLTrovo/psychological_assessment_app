class Instrument < ApplicationRecord
  has_and_belongs_to_many :questions
  has_many :patients

  validates :name, :questions, presence: true
  validates :questions, length: { minimum: 5 }
end
