class AddStartTimeIndexToNikeRun < ActiveRecord::Migration
  def change
    add_index :nike_runs, :start_time, unique: true
  end
end
