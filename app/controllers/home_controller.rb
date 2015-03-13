class HomeController < ApplicationController

  def index
    @num_runs = NikeRun.count
    @total_distance = NikeRun.total_distance.round(1)

    @avg_distance = NikeRun.avg_distance.round(2)
    @avg_pace = NikeRun.avg_pace.strftime("%M'%S\"")

    last_run = NikeRun.last
    if last_run.nil?
      @last_run_time = "Never"
      @days_ago = -1
    else
      @last_run_time = NikeRun.last.start_time
      @days_ago = (Date.today - @last_run_time.to_date).to_i
      @last_run_time = @last_run_time.strftime("%a, %b %d, %I:%M %p")
    end

    if @days_ago < 0
      @days_ago = "Never"
    elsif @days_ago == 0
      @days_ago = "Today"
    elsif @days_ago == 1
      @days_ago = "Yesterday"
    else
      @days_ago = @days_ago.to_s + " days ago"
    end
  end
end
