class Question < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true
	validates :headline, presence: true, length: { maximum: 150 }
	validates :content, presence: true
	default_scope -> {order(created_at: :desc)}
end
