class AddAnonToNotifications < ActiveRecord::Migration[5.1]
  def change
  	add_column :notifications, :anon, :boolean
  end
end
