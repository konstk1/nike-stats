class AddNikeUserIndexToUser < ActiveRecord::Migration
  def change
    add_index :users, :nike_username, unique: true
  end
end
