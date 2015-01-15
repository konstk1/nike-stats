require "json"

class NikeApi
  
  def initialize(username:, password:)
    login_to_nike(username, password)
    get_activity_list_json(count: 999)
  end	

  def distanceByRun
    distances = Array.new
    i = 0
    @activity_list_json["data"].reverse.each { |run| 
      if run["activityType"] == "RUN"
        distances[i] = km_to_mi(run["metricSummary"]["distance"].to_f)
        i = i + 1
      end
    }
    return distances
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
end

def km_to_mi(km)
  return km * 0.621371
end