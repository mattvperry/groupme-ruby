require 'groupme/api'

module GroupMe
  class << self
    # A GroupMe::API, used when callign methods on the GroupMe module itself.
    #
    # @return [GroupMe::API]
    def api
      @api ||= GroupMe::API.new
    end

    def respond_to?(method_name, include_private = false)
      api.respond_to?(method_name, include_private) || super
    end

    private

    def method_missing(method_name, *args, &block)
      return super unless api.respond_to? method_name
      api.send(method_name, *args, &block)
    end
  end
end
