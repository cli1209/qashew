class DeleteAnonToNotifications < ActiveRecord::Migration[5.1]
  def change
  	  remove_column :notifications, :anon, :boolean
  end
end
