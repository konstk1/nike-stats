require 'nike_api'

class NikeSync

  # Look at rspec

  def self.sync
    new_run_count = 0
    nike = NikeApi.new(username: Rails.application.secrets.nike_user_name,
                       password: Rails.application.secrets.nike_password)

    latest_run = NikeRun.last

    if latest_run.present?
      puts "Runs found"
      runs = nike.get_activity_list_json(start_date: NikeRun.last.start_time, end_date: Date.today)
    else
      puts 'Nothing found'
      runs = nike.get_activity_list_json(count: 9999)
    end

    unless runs.nil?
      runs.each { |run_json|
        r = NikeRun.create_from_json(run_json)
        if r.errors.count == 0
          new_run_count += 1
        end
      }
    end

    new_run_count
  end

end