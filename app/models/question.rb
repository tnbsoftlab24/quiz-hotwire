class Question < ApplicationRecord
  belongs_to :quiz
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  scope :ordered, -> { order(created_at: :asc) }

  broadcasts_to ->(question) { "questions" }, inserts_by: :prepend
  def previous_chapter
    quiz.questions.ordered.where("created_at < ?", created_at).last
  end
end
