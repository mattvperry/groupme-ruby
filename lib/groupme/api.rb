require 'faraday_middleware'
require 'groupme/version'
require 'groupme/middleware/json_parse'
require 'groupme/api/groups'

module GroupMe
  class API
    include GroupMe::API::Groups
    ENDPOINT = 'https://api.groupme.com/'

    attr_accessor :token
    attr_accessor :user_agent
    attr_accessor :connection_options
    attr_accessor :middleware

    def initialize(token)
      @token = token
    end

    def user_agent
      @user_agent ||= "groupme-ruby #{GroupMe::VERSION}"
    end

    def connection_options
      @connection_options ||= {
        builder: middleware,
        headers: {
          accept: 'application/json',
          user_agent: user_agent,
          "X-Access-Token" => token
        }
      }
    end

    def connection
      @connection ||= Faraday.new(ENDPOINT, connection_options)
    end

    def middleware
      @middleware ||= Faraday::Builder.new do |builder|
        # Request
        builder.request :json

        # Response
        builder.response :logger
        builder.use GroupMe::Middleware::JsonParse

        # Adapter
        builder.adapter Faraday.default_adapter
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
