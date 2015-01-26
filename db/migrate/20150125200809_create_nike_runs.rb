class CreateNikeRuns < ActiveRecord::Migration
  def change
    create_table :nike_runs do |t|
      t.string 		:activity_id
      t.datetime 	:start_time_utc
      t.string		:device_type
      t.float		:distance_mi
      t.integer		:calories
      t.float 		:duration_mins
      t.string		:shoes

      t.point	:gps_data
      # has_one       :gps_data

      t.timestamps null: false
    end
  end
end
