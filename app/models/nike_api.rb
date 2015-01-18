require "json"

class NikeApi
  
  RunData = Struct.new(:activityId, :startTime, :distance, :duration, :calories)

  def initialize(username:, password:)
    login_to_nike(username, password)
    get_activity_list_json(count: 20)
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
    return run_data
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
    @request_uri_str = endpoint_uri_str + "&access_token=#{@@access_token}"
   	uri = URI.parse(@request_uri_str)
	  response = Net::HTTP.get_response(uri)
	  return JSON.parse(response.body)
  end

  def json_to_run_data(run_json)
    activity_id = run_json["activityId"]
    start_time   = DateTime.iso8601(run_json["startTime"]).new_offset("-05:00")
    distance    = km_to_mi(run_json["metricSummary"]["distance"].to_f)
    duration    = str_to_mins(run_json["metricSummary"]["duration"])
    calories    = run_json["metricSummary"]["calories"].to_f

    return RunData.new(activity_id, start_time, distance, duration, calories)
  end
end

def km_to_mi(km)
  return km * 0.621371
end

def str_to_mins (str)
  # string format is hh:mm:ss.SSS
  str = str.split(':');
  return 60*str[0].to_f + 1*str[1].to_f + str[2].to_f/60;
end