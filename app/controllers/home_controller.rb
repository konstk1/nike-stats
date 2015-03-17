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

    current_goal_data
  end

  def current_goal_data
    @goal = NikeGoal.order(:start_time).last
    dates = (@goal.start_time.to_datetime...@goal.end_time.to_datetime).map { |d| d.end_of_day }

    runs = @goal.get_runs

    plan_distance = Array.new(dates.count, 0)
    actual_distance = Array.new(dates.count, 0)

    miles_per_day = @goal.distance_mi / dates.count

    dates.each_with_index { |date, i|
      plan_distance[i] = (i+1) * miles_per_day
      if date <= DateTime.now.end_of_day
        actual_distance[i] = runs.select { |run| run.start_time <= date }.map { |run| run.distance_mi }.sum
      else
        actual_distance[i] = -1
      end
    }


    gon.goal_start_date = dates.first.beginning_of_day.to_i * 1000
    gon.goal_date_interval = 1.day.seconds * 1000
    gon.goal_plan_distance = plan_distance
    gon.goal_actual_distance = actual_distance.select { |d| d >= 0 }
  end
end
