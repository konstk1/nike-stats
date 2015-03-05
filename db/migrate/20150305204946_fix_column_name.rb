class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :nike_runs, :duration_mins, :duration_min
  end
end
