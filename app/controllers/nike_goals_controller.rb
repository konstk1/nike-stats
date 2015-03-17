class NikeGoalsController < ApplicationController

  def new
  end

  def create
    @goal = NikeGoal.create_from_form(nike_goal_params)
    redirect_to @goal
  end

  def index
    @goals = NikeGoal.all
  end

  def show
    @goal = NikeGoal.find(params[:id])
    dates = (@goal.start_time.to_datetime...@goal.end_time.to_datetime).map { |d| d.end_of_day }

    runs = @goal.get_runs

    plan_distance  = Array.new(dates.count, 0)
    actual_distance = Array.new(dates.count, 0)

    miles_per_day = @goal.distance_mi / dates.count

    dates.each_with_index { |date, i |
      plan_distance[i]  = (i+1) * miles_per_day
      if date <= DateTime.now.end_of_day
        actual_distance[i] = runs.select { |run| run.start_time <= date }.map { |run| run.distance_mi }.sum
      else
        actual_distance[i] = -1
      end
    }


    gon.goal_start_date      = dates.first.beginning_of_day.to_i * 1000
    gon.goal_date_interval   = 1.day.seconds * 1000
    gon.goal_plan_distance  = plan_distance
    gon.goal_actual_distance = actual_distance.select { |d| d >= 0 }
  end

  private

  def nike_goal_params
    params.require(:nike_goal).permit(:title, :start_date_time, :duration_weeks, :distance_miles)
  end

end
