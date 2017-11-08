class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :user_id, presence: true
	validates :content, presence: true

end
