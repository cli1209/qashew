class QuestionsAddRank < ActiveRecord::Migration[5.1]
  def change
  	add_column :questions, :rank, :integer
  end
end
