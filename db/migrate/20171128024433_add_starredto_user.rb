class AddStarredtoUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :starred, :integer, array: true, default: []
  end
end