class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :instruments
end
