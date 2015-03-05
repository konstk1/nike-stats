require 'json'
require 'utils'

class NikeApi

  # TODO: when getting gps, get timezone based on first lat/lon and update start_time
  # TODO: get city based on lat/lon

  RunData = Struct.new(:activity_id, :start_time, :distance, :duration, :calories)
  GpsPoint = Struct.new(:lat, :lon, :el)

  def initialize(username:, password:)
    login_to_nike(username, password)
    get_activity_list_json(count: 999)
  end	

  def get_run_data
    run_data = Array.new
    i = 0
    @activity_list_json["data"].reverse.each { |run| 
      if run["activityType"] == "RUN"
        run_data[i] = json_to_run_data(run)
        i = i + 1
      end
    }
    run_data
  end

  def get_gps_data(activity_id)
    gps_data = Array.new

    end_point = "https://api.nike.com/v1/me/sport/activities/#{activity_id}/gps"
    gps_json = get_json_from_endpoint(end_point)

    waypoints = gps_json["waypoints"]

    if waypoints != nil
      waypoints.each { |point|
        gps_data.push(GpsPoint.new(point["latitude"], point["longitude"], point["elevation"]))
      }
    end

    gps_data
  end

  # test func
  def log_gps_data
    run_data = get_run_data()

    File.open("/Users/Kon/Developer/nike-stats/gps_data_kon.txt", "w") { |io|
      io.puts "run_num, lat, lon, el, activity_id\n"
      run_data.each_with_index { |run, i|
        puts "[#{i+1}/#{run_data.count}]: Getting gps for #{run.activity_id}"
        gps_data = get_gps_data(run.activity_id)
        gps_data.each { |point|
          io.puts "#{i+1}, #{point.lat}, #{point.lon}, #{point.el}, #{run.activity_id}\n"
        }
      }
    }

    "Done"
  end

private
  @@access_token = ""

  def login_to_nike(username, password)
    if @@access_token == ""
  	  uri = URI.parse('https://developer.nike.com/services/login')
	    response = Net::HTTP.post_form(uri,  {"username" => username, "password" => password})
	    @@access_token = JSON.parse(response.body)["access_token"]
    else
       Rails.logger.debug "Acces Token is" + @@access_token
    end
  end

  def get_activity_list_json(count:)
    end_point = "https://api.nike.com/v1/me/sport/activities" + "?count=#{count}"
    @activity_list_json = get_json_from_endpoint(end_point)
  end

  def get_json_from_endpoint(endpoint_uri_str)
    join_char = '?'
    if endpoint_uri_str.index('?') != nil
      join_char = '&'
    end
    @request_uri_str = endpoint_uri_str + join_char + "access_token=#{@@access_token}"
    Rails.logger.info "Loading URI: #{@request_uri_str}"
   	uri = URI.parse(@request_uri_str)
	  response = Net::HTTP.get_response(uri)
	  JSON.parse(response.body)
  end

  def json_to_run_data(run_json)
    activity_id = run_json["activityId"]
    start_time  = DateTime.iso8601(run_json["startTime"]).new_offset("-05:00")
    distance    = Utils::km_to_mi(run_json["metricSummary"]["distance"].to_f)
    duration    = Utils::str_to_mins(run_json["metricSummary"]["duration"])
    calories    = run_json["metricSummary"]["calories"].to_f

    RunData.new(activity_id, start_time, distance, duration, calories)
  end
end

