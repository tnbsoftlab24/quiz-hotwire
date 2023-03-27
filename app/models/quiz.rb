class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions

  validates :title, presence: true
  validates :title, uniqueness: true

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    quiz.questions.next(self.id).first
  end

  def previous
    quiz.questions.previous(self.id).first
  end

  scope :ordered, -> { order(id: :desc) }
  broadcasts_to ->(quiz) { "quizzes" }, inserts_by: :prepend
end
