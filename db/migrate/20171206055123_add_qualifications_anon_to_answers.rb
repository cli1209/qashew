class AddQualificationsAnonToAnswers < ActiveRecord::Migration[5.1]
  def change
  	add_column :answers, :anon, :boolean
  	add_column :answers, :qualifications, :string
  end
end
