class RenameAnswersContent < ActiveRecord::Migration[5.1]
  def change
  	rename_column :answers, :answer, :content
  end
end
