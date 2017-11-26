class Question < ApplicationRecord
  	acts_as_votable
  	acts_as_taggable
	belongs_to :user
	has_many :answers
	validates :user_id, presence: true
	validates :headline, presence: true, length: { maximum: 150 }
	validates :content, presence: true

	scope :term, -> (term) { where("headline ILIKE ? OR content ILIKE ?", "%#{term}%", "%#{term}%") | Question.tagged_with(term) }
end
