class ChangeQualificationsFormatInAnswers < ActiveRecord::Migration[5.1]
  def change
  	change_column :answers, :qualifications, :text
  end
end
