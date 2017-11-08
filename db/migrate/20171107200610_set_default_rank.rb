class SetDefaultRank < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :questions, :rank, 0
  end
end
