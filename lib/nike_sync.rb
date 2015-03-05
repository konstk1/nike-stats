require 'nike_api'

class NikeSync

  # Look at rspec

  def self.sync
      puts 'looking for runs'
      latest_run = NikeRun.last

      nike = NikeApi.new(username: Rails.application.secrets.nike_user_name,
                         password: Rails.application.secrets.nike_password)

      if latest_run.present?
        puts "Run found #{latest_run}"
        # grab date
      else
        puts 'Nothing found'
        nike.get_activity_list_json(count: 999).each { |run_json|
          run = NikeRun.create_from_json(run_json)
          puts "Created ID: #{run.activity_id}"
        }
      end

    # find most recent run in db
    # request all activity from that date to today
    # if db empty, request all activity

    # handle overlapping runs
    # populate new runs into model
  end

end