class NikeGoalsController < ApplicationController

  def new
  end

  def create
    @goal = NikeGoal.create_from_form(nike_goal_params)
    redirect_to @goal
  end

  def index
    @goals = NikeGoal.order("start_time DESC")
    @goals.each { |goal|
      goal.calculate_stats
    }
  end

  def show
    @goal = NikeGoal.find(params[:id])
    @goal.calculate_stats.to_gon(gon)
  end

  private

  def nike_goal_params
    params.require(:nike_goal).permit(:title, :start_date_time, :duration_weeks, :distance_miles)
  end

end
