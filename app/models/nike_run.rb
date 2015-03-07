class NikeRun < ActiveRecord::Base

  def self.create_from_json(run_json)
    nike_run = NikeRun.new

    nike_run.activity_id    = run_json["activityId"]

    time_zone = ActiveSupport::TimeZone.new(run_json["activityTimeZone"])
    if time_zone.nil?
      time_zone = ActiveSupport::TimeZone.new("UTC")
    end
    nike_run.start_time     = DateTime.iso8601(run_json["startTime"]) + time_zone.utc_offset.seconds

    nike_run.distance_mi    = Utils::km_to_mi(run_json["metricSummary"]["distance"].to_f)
    nike_run.duration_min   = Utils::str_to_mins(run_json["metricSummary"]["duration"])
    nike_run.calories       = run_json["metricSummary"]["calories"].to_f
    nike_run.device_type    = run_json["deviceType"]

    nike_run.save

    nike_run
  end

end
