class NikeRun < ActiveRecord::Base

  def self.create_from_json(run_json)
    nike_run = NikeRun.new

    nike_run.activity_id    = run_json["activityId"]
    nike_run.start_time_utc = DateTime.iso8601(run_json["startTime"])     #.new_offset("-05:00")
    nike_run.distance_mi    = Utils::km_to_mi(run_json["metricSummary"]["distance"].to_f)
    nike_run.duration_min   = Utils::str_to_mins(run_json["metricSummary"]["duration"])
    nike_run.calories       = run_json["metricSummary"]["calories"].to_f
    nike_run.device_type    = run_json["deviceType"]

    nike_run.save

    nike_run
  end

end
