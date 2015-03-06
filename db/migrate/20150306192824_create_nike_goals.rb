class CreateNikeGoals < ActiveRecord::Migration
  def change
    create_table :nike_goals do |t|
      t.float :distance_mi
      t.float :duration_wk
      t.datetime :start_time_utc
      t.datetime :end_time_utc

      t.timestamps null: false
    end
  end
end
