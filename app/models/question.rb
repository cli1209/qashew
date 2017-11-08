class Question < ApplicationRecord
  	acts_as_votable
	belongs_to :user
	has_many :answers
	validates :user_id, presence: true
	validates :headline, presence: true, length: { maximum: 150 }
	validates :content, presence: true
	default_scope -> {order(created_at: :desc)}

	def self.search(term)
	  if term
	    where("headline ILIKE ? OR content ILIKE ?", "%#{term}%", "%#{term}%").order('id DESC')
	  else
	    order('id DESC')
	  end
	end
end
