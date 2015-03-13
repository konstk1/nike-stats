class HomeController < ApplicationController

  def index
    @runs_summary = Hash.new

    @runs_summary[:num_runs] = NikeRun.count
    @runs_summary[:total_distance] = NikeRun.total_distance.round(1)

    @runs_summary[:avg_distance] = NikeRun.avg_distance.round(2)
    @runs_summary[:avg_pace] = NikeRun.avg_pace.strftime("%M'%S\"")

    last_run = NikeRun.last
    if last_run.nil?
      @runs_summary[:last_run_time] = "Never"
      days_ago = -1
    else
      last_run_time = NikeRun.last.start_time
      days_ago = (Date.today - last_run_time.to_date).to_i
      @runs_summary[:last_run_time] = last_run_time.strftime("%a, %b %d, %I:%M %p")

    end

    if days_ago < 0
      @runs_summary[:days_ago] = "Never"
    elsif days_ago == 0
      @runs_summary[:days_ago] = "Today"
    elsif days_ago == 1
      @runs_summary[:days_ago] = "Yesterday"
    else
      @runs_summary[:days_ago] = days_ago.to_s + " days ago"
    end
  end
end
