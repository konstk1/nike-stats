class NikeChartsController < ApplicationController

  def initialize
  	@nike = NikeApi.new(username: Rails.application.secrets.nike_user_name, 
  		                password: Rails.application.secrets.nike_password)
  	super
  end

  def index
  	@distances = @nike.get_run_data
  end
  
end
