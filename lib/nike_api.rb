require 'json'
require 'utils'

class NikeApi

  # TODO: get city based on lat/lon

  RunData = Struct.new(:activity_id, :start_time, :distance, :duration, :calories)
  GpsPoint = Struct.new(:lat, :lon, :el)

  def initialize(username:, password:)
    @user = User.find_by(nike_username: username)
    if @user.nil?
      @user = User.new
      @user.nike_username = username
    end

    if @user.need_token?
      access_token, expires_at = login_to_nike(username, password)
      raise StandardError, "Fail to login to NikePlus." if access_token.nil?
      @user.nike_access_token = access_token
      @user.token_expiration_time = expires_at
      @user.save
    end

  end

  def get_activity_list_json_with_count(count:)
    end_point = "https://api.nike.com/v1/me/sport/activities/RUNNING" + "?count=#{count}"
    activity_list_json = get_json_from_endpoint(end_point)
    activity_list_json["data"].reverse   # return in chronological order
  end

  def get_activity_list_json_with_dates(start_date:, end_date:)
    count = 99999
    start_date_str = start_date.strftime("%Y-%m-%d")
    end_date_str   =   end_date.strftime("%Y-%m-%d")

    end_point = "https://api.nike.com/v1/me/sport/activities/RUNNING" +
                "?count=#{count}&startDate=#{start_date_str}&endDate=#{end_date_str}"
    activity_list_json = get_json_from_endpoint(end_point)
    activity_list_json["data"].reverse unless activity_list_json["data"].nil?  # return in chronological order
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

  def login_to_nike(username, password)
    uri = URI.parse('https://developer.nike.com/services/login')
    response = Net::HTTP.post_form(uri, {username: username, password: password})

    access_token = JSON.parse(response.body)["access_token"]
    expires_at = DateTime.now.utc + JSON.parse(response.body)["expires_in"].to_i.seconds

    return access_token, expires_at
  end

  def get_json_from_endpoint(endpoint_uri_str)
    join_char = '?'
    if endpoint_uri_str.index('?') != nil
      join_char = '&'
    end
    @request_uri_str = endpoint_uri_str + join_char + "access_token=#{@user.nike_access_token}"
    Rails.logger.info "Loading URI: #{@request_uri_str}"
   	uri = URI.parse(@request_uri_str)
	  response = Net::HTTP.get_response(uri)
	  JSON.parse(response.body)
  end

end

