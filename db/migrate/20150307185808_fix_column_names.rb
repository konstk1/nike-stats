class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :nike_runs, :start_time_utc, :start_time
    rename_column :nike_goals, :start_time_utc, :start_time
    rename_column :nike_goals, :end_time_utc, :end_time
  end
end
