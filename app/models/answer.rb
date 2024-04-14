class Answer < ApplicationRecord
  belongs_to :question

  validates :text, :points, presence: true
end
