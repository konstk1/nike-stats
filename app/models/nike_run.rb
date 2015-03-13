class NikeRun < ActiveRecord::Base
  validates :activity_id, uniqueness: true

  # TODO: create index on start time

  def self.create_from_json(run_json)
    nike_run = NikeRun.new

    nike_run.activity_id    = run_json["activityId"]

    time_zone = ActiveSupport::TimeZone.new(run_json["activityTimeZone"])
    if time_zone.nil?
      time_zone = ActiveSupport::TimeZone.new("UTC")
    end
    nike_run.start_time     = time_zone.utc_to_local(DateTime.iso8601(run_json["startTime"]))

    nike_run.distance_mi    = Utils::km_to_mi(run_json["metricSummary"]["distance"].to_f)
    nike_run.duration_min   = Utils::str_to_mins(run_json["metricSummary"]["duration"])
    nike_run.calories       = run_json["metricSummary"]["calories"].to_f
    nike_run.device_type    = run_json["deviceType"]

    nike_run.save

    nike_run
  end

  def self.total_distance
    @@total_distance = NikeRun.sum(:distance_mi).round(1)
  end

  def self.avg_distance
    NikeRun.count > 0 ? NikeRun.average(:distance_mi) : 0.0
  end

  def self.avg_pace
    if @@total_distance.nil?
      total_distance
    end

    NikeRun.count > 0 ? Time.at(NikeRun.sum(:duration_min) / @@total_distance * 60) : Time.at(0).utc
  end

  private
    @@total_distance = nil
end
