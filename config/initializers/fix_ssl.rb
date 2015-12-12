require 'open-uri'
require 'net/https'

module Net
  class HTTP
    alias_method :original_use_ssl=, :use_ssl=

    @original_ca_file

    def use_ssl=(flag)
      # path = ( Rails.env == "development") ? "lib/ca-bundle.crt" : "/usr/lib/ssl/certs/ca-certificates.crt"
      # if Rails.env == "production"
        path = 'lib/ca-bundle.crt'
        @original_ca_file = self.ca_file
        self.ca_file = Rails.root.join(path).to_s
        self.verify_mode = OpenSSL::SSL::VERIFY_PEER
        self.ssl_version = :TLSv1_2
        self.original_use_ssl = flag
      # end
    end

    def restore_ca_file
      self.ca_file = @original_ca_file
    end
  end
end