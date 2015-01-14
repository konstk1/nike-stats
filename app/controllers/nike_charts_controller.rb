class NikeChartsController < ApplicationController
  def index
  	login_to_nike(Rails.application.secrets.nike_user_name, Rails.application.secrets.nike_password)
  	@list_activities_json = get_list_activities_json()
  	logger.debug @list_activities_json
  end

  def login_to_nike(username, password)
  	uri = URI.parse('https://developer.nike.com/services/login')
	response = Net::HTTP.post_form(uri,  {"username" => username, "password" => password})
	
	@access_token = JSON.parse(response.body)["access_token"]
  end

  def get_list_activities_json
	req_str = "https://api.nike.com/v1/me/sport?access_token=#{@access_token}"
	return get_json(req_str)
  end

  def get_json(request_uri_str)
  	request_uri_str = request_uri_str + @access_token + "&clientid=de5943d987b5976095d03df4a1281a2b"
  	logger.debug request_uri_str
   	uri = URI.parse(request_uri_str)
	response = Net::HTTP.get_response(uri)
	return response.body
  end
end
