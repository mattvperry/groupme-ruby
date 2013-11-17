require 'multi_json'

module GroupMe
  module Middleware
    class JsonParse < Faraday::Response::Middleware
      def on_complete(env)
        body = env[:body]
        return body if body.strip.empty? # Add some more error handling

        json = MultiJson.load(body, symbolize_keys: true)
        data = json.delete :response
        metadata = json.delete :meta
        errors = []

        if metadata.has_key? :error
          errors << metadata.delete(:error)
        elsif metadata.has_key? :errors
          errors.concat metadata.delete(:errors)
        end

        env[:body] = {
          data: data,
          errors: errors,
          metadata: metadata
        }
      end
    end
  end
end
