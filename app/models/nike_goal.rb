class NikeGoal < ActiveRecord::Base
  def self.create_from_form(params)
    goal = NikeGoal.new
    goal.title = params[:title]
    goal.start_time_utc = params[:start_date_time]
    goal.duration_wk = params[:duration_weeks]
    goal.distance_mi = params[:distance_miles]

    goal.end_time_utc = params[:start_date_time]  # add duration in weeks to this

    goal.save
    goal
  end
end
