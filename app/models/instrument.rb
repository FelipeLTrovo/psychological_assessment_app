class Instrument < ApplicationRecord
  has_and_belongs_to_many :questions
  has_many :patients
end
