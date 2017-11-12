class AddCachedVotesToAnswers < ActiveRecord::Migration[5.1]
  def self.up
    add_column :answers, :cached_weighted_score, :integer, :default => 0

    # Uncomment this line to force caching of existing votes
    Answer.find_each(&:update_cached_votes)
  end

  def self.down
    remove_column :answers, :cached_votes_total
    remove_column :answers, :cached_votes_score
    remove_column :answers, :cached_votes_up
    remove_column :answers, :cached_votes_down
    remove_column :answers, :cached_weighted_score
    remove_column :answers, :cached_weighted_total
    remove_column :answers, :cached_weighted_average
  end
end
