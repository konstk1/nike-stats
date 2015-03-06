class AddTitleToNikeGoals < ActiveRecord::Migration
  def change
    add_column :nike_goals, :title, :string
  end
end
