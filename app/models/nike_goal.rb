class NikeGoal < ActiveRecord::Base
  def self.create_from_form(params)
    goal = NikeGoal.new
    goal.title       = params[:title]
    goal.start_time  = DateTime.strptime(params[:start_date_time], "%m/%d/%Y")
    goal.duration_wk = params[:duration_weeks]
    goal.distance_mi = params[:distance_miles]

    goal.end_time    = (goal.start_time + goal.duration_wk.weeks)

    goal.save
    goal
  end

  def self.most_recent
    order(:start_time).last
  end

  def get_runs
    runs = NikeRun.where(start_time: start_time...end_time).order(:start_time)
  end

  def stats
    dates = (start_time.to_datetime...end_time.to_datetime).map { |d| d.end_of_day }

    runs = get_runs

    @plan_distance = Array.new(dates.count, 0)
    @actual_distance = Array.new(0)

    miles_per_day = distance_mi / dates.count

    dates.each_with_index { |date, i|
      @plan_distance[i] = (i+1) * miles_per_day
      if date <= DateTime.now.end_of_day
        @actual_distance << runs.select { |run| run.start_time <= date }.map { |run| run.distance_mi }.sum
      end
    }

    self
  end

  def to_gon(gon)
    gon.goal_start_date = start_time.beginning_of_day.to_i * 1000
    gon.goal_date_interval = 1.day.seconds * 1000
    gon.goal_plan_distance = @plan_distance
    gon.goal_actual_distance = @actual_distance
  end
end
