class Question < ApplicationRecord
  	acts_as_votable
  	acts_as_taggable
	belongs_to :user
	has_many :answers
	has_many :notifications, dependent: :destroy
	validates :user_id, presence: true
	validates :headline, presence: true, length: { maximum: 150 }
	validates :content, presence: true

	def self.tag_search(tag_id)
		if tag_id
			Question.tagged_with(tag_id)
		end
	end

	scope :term, -> (term) { where("headline ILIKE ? OR content ILIKE ?", "%#{term}%", "%#{term}%") | Question.tagged_with(term) }

end
