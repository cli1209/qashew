class Page < ApplicationRecord

	scope :term, -> (term) { where("headline ILIKE ? OR content ILIKE ?", "%#{term}%", "%#{term}%") | Question.tagged_with(term) }
end
