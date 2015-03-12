class HomeController < ApplicationController

  def index
    @num_runs = NikeRun.count
    @total_distance = NikeRun.sum(:distance_mi).round(1)

    @avg_distance = NikeRun.average(:distance_mi).round(2)
    @avg_pace = Time.at(NikeRun.sum(:duration_min) / @total_distance * 60).strftime("%M'%S\"")

    @last_run_time = NikeRun.last.start_time
    @days_ago = (Date.today - @last_run_time.to_date).to_i
    if @days_ago == 0
      @days_ago = "Today"
    elsif @days_ago == 1
      @days_ago = "Yesterday"
    else
      @days_ago = @days_ago.to_s + " days ago"
    end
  end
end
