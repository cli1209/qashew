class AddResolvedToQuestions < ActiveRecord::Migration[5.1]
  def change
  	add_column :questions, :resolved, :boolean, default: false
  end
end
