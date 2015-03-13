require 'nike_sync'
require 'run_stats'

class NikeChartsController < ApplicationController

  def initialize
  	@run_stats = RunStats.new(NikeRun.all)
  	super
  end

  def index
  	@distances,@num_runs = @run_stats.runs_by_distance
  	@days_of_week, @num_runs_wday = @run_stats.runs_by_day_of_week
  	@wday, @avg_distance = @run_stats.avg_distance_by_day_of_week

  	@run_stats.pace_trend
  end

  def sync
    @num_new_runs = NikeSync.sync
    render json: {num_new_runs: @num_new_runs}
  end
  
end
