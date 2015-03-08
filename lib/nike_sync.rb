require 'nike_api'

class NikeSync

  # Look at rspec

  def self.sync
      puts 'looking for runs'
      latest_run = NikeRun.last

      nike = NikeApi.new(username: Rails.application.secrets.nike_user_name,
                         password: Rails.application.secrets.nike_password)

      if latest_run.present?
        puts "Runs found"
        runs = nike.get_activity_list_json(start_date: NikeRun.last.start_time, end_date: Date.today)
      else
        puts 'Nothing found'
        runs = nike.get_activity_list_json(count: 999)
      end

      unless runs.nil?
        runs.each { |run_json|
          run = NikeRun.create_from_json(run_json)
        }
      end

    # find most recent run in db
    # request all activity from that date to today
    # if db empty, request all activity

    # handle overlapping runs
    # populate new runs into model
  end

end