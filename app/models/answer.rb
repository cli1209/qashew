class Answer < ApplicationRecord
  	acts_as_votable

  belongs_to :question
  belongs_to :user
  validates :user_id, presence: true
	validates :content, presence: true
	default_scope -> {order(:cached_weighted_score => :desc)}


end
