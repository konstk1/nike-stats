class RunStats

  def initialize(run_data)
  	@run_data = run_data
  end

  def runs_by_distance
  	num_runs = Hash.new

  	@run_data.each_with_index { |run, i|  
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

end

def down_to_nearest_half (x)
  return (x - x.floor).round/2.0 + x.floor
end

# function distanceToColor (dist)
# {
#   var idx = (downToNearestHalf(dist) - 2) / 0.5;
#   var colors = ['blue','cyan','green','yellow','orange','pink','red','red','darkred'];
#   return colors[idx];
# }