class Question < ApplicationRecord
  	acts_as_votable
  	acts_as_taggable
	belongs_to :user
	has_many :answers
	has_many :notifications, dependent: :destroy
	validates :user_id, presence: true
	validates :headline, presence: true, length: { maximum: 150 }
	validates :content, presence: true

	validate :tag_size 
	def tag_size
	 self.tag_list.each do |tag|
	  errors[:tag_list] << "must only contain 3-letter departmental abbreviations" if tag.length != 3 
	 end
	end

	def self.tag_search(tag_id)
		if tag_id
			Question.tagged_with(tag_id)
		end
	end

	scope :term, -> (term) { where("headline ILIKE ? OR content ILIKE ?", "%#{term}%", "%#{term}%") | Question.tagged_with(term) }

end
