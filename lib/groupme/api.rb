require 'faraday_middleware'
require 'groupme/version'
require 'groupme/middleware/json_parse'

module GroupMe
  class API
    attr_accessor :token
    attr_accessor :user_agent
    attr_accessor :connection

    def initialize(token)
      @token = token
    end

    def user_agent
      @user_agent ||= "groupme-ruby #{GroupMe::VERSION}"
    end

    def connection
      @connection ||= Faraday.new 'https://api.groupme.com/' do |conn|
        # Request
        conn.request :json
        conn.headers[:user_agent] = user_agent
        conn.headers["X-Access-Token"] = token

        # Response
        conn.response :logger
        conn.use GroupMe::Middleware::JsonParse

        # Adapter
        conn.adapter Faraday.default_adapter
      end
    end

    #private

    [:get, :post, :put, :delete].each do |verb|
      define_method verb do |path, params = nil|
        connection.send(verb, "/v3#{path}", params).env
      end
    end
  end
end
