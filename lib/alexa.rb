class Alexa

  VERSION = "1.0"
  APPLICATION_ID = "amzn1.echo-sdk-ams.app.000000-d0ed-0000-ad00-000000d00ebe"

  def process_request(request)
    if request["version"] != VERSION
      return :forbidden, {status: "version mismatch"}
    end

    if !request["session"] || !request["session"]["application"] ||
       request["session"]["application"]["applicationId"] != APPLICATION_ID
      return :forbidden, {status: "invalid application id"}
    end

    response = {}

    case request["request"]["type"]
      when "LaunchRequest"
        response = process_launch
      when "IntentRequest"
        response = process_intent(request["request"]["intent"])
      when "SessionEndedRequest"
        response = process_session_end
      else
        return :forbidden, {status: "invalid request type"}
    end

    return :ok, response
    end

private

  def process_launch()
    puts "Launched"
  end

  def process_intent(intent)
    puts "Intent: " + intent.to_s
    intent
  end

  def process_session_end()
    puts "Session Ended"
  end

end