class RunStats

  def initialize(run_data)
  	@run_data = run_data
  end

  def runs_by_distance
  	num_runs = Hash.new

  	@run_data.each { |run|  
  	  d = down_to_nearest_half(run.distance)
  	  if num_runs[d]
  	  	num_runs[d] += 1
  	  else
  	  	num_runs[d] = 1
  	  end
  	}
  	
  	# sort by distance (key)
  	num_runs = Hash[num_runs.sort_by { |k, v| k }]

  	return num_runs.keys, num_runs.values
  end

  def runs_by_day_of_week
  	num_runs = Hash.new

  	@run_data.each { |run|
  	  day = run.start_time.wday
  	  if num_runs[day]
  	  	num_runs[day] += 1
  	  else
  	  	num_runs[day] = 1
  	  end
  	}

  	num_runs = Hash[num_runs.sort_by { |k, v| k }]

  	return num_runs.keys.map { |e| $days_of_week[e] }, num_runs.values
  end

  def avg_distance_by_day_of_week
  	avg_distance = Array.new(7,0)

  	grouped_by_wday = @run_data.group_by { |run| run.start_time.wday }

  	grouped_by_wday.each_pair { |wday, runs|
  	  avg_distance[wday] = runs.reduce(0) { |sum, run| sum + run.distance } / runs.length
  	}

  	return $days_of_week, avg_distance

  end

end

$days_of_week = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

def down_to_nearest_half (x)
  return (x - x.floor).round/2.0 + x.floor
end

# function distanceToColor (dist)
# {
#   var idx = (downToNearestHalf(dist) - 2) / 0.5;
#   var colors = ['blue','cyan','green','yellow','orange','pink','red','red','darkred'];
#   return colors[idx];
# }