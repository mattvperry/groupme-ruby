require "her"
require "faraday_middleware"

require "groupme/version"
require "groupme/middleware/json_parse"

module GroupMe
  MODELS = %i(group)

  class << self
    def configure(&block)
      opts = Struct.new(:token).new
      yield opts

      raise "An authentication token is required" unless opts.token

      Her::API.setup url: 'https://api.groupme.com/v3/' do |conn|
        # Request
        conn.request :json
        conn.headers["X-Access-Token"] = opts.token

        # Response
        conn.response :logger
        conn.use GroupMe::Middleware::JsonParse

        # Adapter
        conn.adapter Faraday.default_adapter
      end

      require_libs *MODELS
    end

    private

    def require_libs(*libs)
      libs.each { |lib| require "groupme/#{lib}" }
    end

    def const_missing(name)
      if MODELS.include? name.downcase
        raise "You must configure GroupMe before using any models"
      else
        raise NameError, "uninitialized constant #{self.name}::#{name}"
      end
    end
  end
end
