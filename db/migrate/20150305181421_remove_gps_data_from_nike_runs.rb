class RemoveGpsDataFromNikeRuns < ActiveRecord::Migration
  def change
    remove_column :nike_runs, :gps_data, :point
  end
end
