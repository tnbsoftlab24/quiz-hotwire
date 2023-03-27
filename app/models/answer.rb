class Answer < ApplicationRecord
  belongs_to :question

  delegate :quiz, to: :question
  broadcasts_to ->(answer) { "answers" }, inserts_by: :prepend
end
