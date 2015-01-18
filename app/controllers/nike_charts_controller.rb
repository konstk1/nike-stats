class NikeChartsController < ApplicationController

  def initialize
  	@nike = NikeApi.new(username: Rails.application.secrets.nike_user_name, 
  		                password: Rails.application.secrets.nike_password)
  	@run_stats = RunStats.new(@nike.get_run_data)
  	super
  end

  def index
  	@distances,@num_runs = @run_stats.runs_by_distance
  	logger.info @distances
  	logger.info @num_runs
  end
  
end
