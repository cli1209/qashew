class Question < ApplicationRecord
  	acts_as_votable
	belongs_to :user
	has_many :answers
	validates :user_id, presence: true
	validates :headline, presence: true, length: { maximum: 150 }
	validates :content, presence: true
	default_scope -> {order(:cached_weighted_score => :desc)}

	def self.search(term)
	  if term
	    where("headline ILIKE ? OR content ILIKE ?", "%#{term}%", "%#{term}%").order('id DESC')
	  else
	    order(:cached_weighted_score => :desc)
	  end
	end
end
