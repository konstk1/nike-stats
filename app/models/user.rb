class User < ActiveRecord::Base
  validates :nike_username, uniqueness: true

  def need_token?
    if token_expiration_time.nil? || token_expiration_time <= DateTime.now.utc
      return true
    end

    false
  end

end
