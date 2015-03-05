require 'nike_api'
require 'run_stats'

class NikeChartsController < ApplicationController
  @@nike = nil
  def initialize
  	# for now, don't reload data every time
  	if @@nike.nil? 
  	  @@nike = NikeApi.new(username: Rails.application.secrets.nike_user_name, 
  		                     password: Rails.application.secrets.nike_password)
  	else
  	  logger.info "Using cached data." 
  	end
  	@run_stats = RunStats.new(@@nike.get_run_data)
  	super
  end

  def index
  	@distances,@num_runs = @run_stats.runs_by_distance
  	@days_of_week, @num_runs_wday = @run_stats.runs_by_day_of_week
  	@wday, @avg_distance = @run_stats.avg_distance_by_day_of_week

  	@run_stats.pace_trend
  end
  
end
