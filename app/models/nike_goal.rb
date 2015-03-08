class NikeGoal < ActiveRecord::Base
  def self.create_from_form(params)
    goal = NikeGoal.new
    goal.title       = params[:title]
    goal.start_time  = DateTime.strptime(params[:start_date_time], "%m/%d/%Y")
    goal.duration_wk = params[:duration_weeks]
    goal.distance_mi = params[:distance_miles]

    goal.end_time    = (goal.start_time + goal.duration_wk.weeks).end_of_day

    goal.save
    goal
  end

  def get_runs
    runs = NikeRun.where(start_time: start_time...end_time).order(:start_time)
  end
end
