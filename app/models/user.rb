class User < ActiveRecord::Base
  validates :nike_username, uniqueness: true

  def need_token?

    if token_expiration_time.nil? || token_expiration_time <= DateTime.now.utc
      Rails.logger.info("Need token")
      return true
    end

    Rails.logger.info("Don't need token #{token_expiration_time} vs #{DateTime.now.utc}")
    false
  end

end
