require 'json'
require 'utils'

class NikeApi

  # TODO: when getting gps, get timezone based on first lat/lon and update start_time
  # TODO: get city based on lat/lon

  RunData = Struct.new(:activity_id, :start_time, :distance, :duration, :calories)
  GpsPoint = Struct.new(:lat, :lon, :el)

  def initialize(username:, password:)
    login_to_nike(username, password)
  end

  def get_activity_list_json(count:)
    end_point = "https://api.nike.com/v1/me/sport/activities/RUNNING" + "?count=#{count}"
    activity_list_json = get_json_from_endpoint(end_point)
    activity_list_json["data"].reverse   # return in chronological order
  end

  def get_activity_list_json(start_date:, end_date:)
    count = 99999
    start_date_str = start_date.strftime("%Y-%m-%d")
    end_date_str   =   end_date.strftime("%Y-%m-%d")

    end_point = "https://api.nike.com/v1/me/sport/activities/RUNNING" +
                "?count=#{count}&startDate=#{start_date_str}&endDate=#{end_date_str}"
    activity_list_json = get_json_from_endpoint(end_point)
    activity_list_json["data"].reverse   # return in chronological order
  end

  def get_gps_data(activity_id)
    gps_data = Array.new

    end_point = "https://api.nike.com/v1/me/sport/activities/#{activity_id}/gps"
    gps_json = get_json_from_endpoint(end_point)

    waypoints = gps_json["waypoints"]

    unless waypoints.nil?
      waypoints.each { |point|
        gps_data.push(GpsPoint.new(point["latitude"], point["longitude"], point["elevation"]))
      }
    end

    gps_data
  end

  # test func
  def log_gps_data
    run_data = NikeRun.all

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
	    response = Net::HTTP.post_form(uri,  {:username => username, :password => password})
	    @@access_token = JSON.parse(response.body)["access_token"]
    else
       Rails.logger.debug "Access Token is" + @@access_token
    end
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

end

