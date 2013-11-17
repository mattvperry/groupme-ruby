module GroupMe
  class API
    module Utils
      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @return [Object]
      def object_from_response(klass, request_method, path, options = {})
        response = send(request_method, path, options)
        klass.from_response(response)
      end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @return [Array]
      def objects_from_response(klass, request_method, path, options = {})
        response = send(request_method, path, options)[:body][:data]
        objects_from_array(klass, response)
      end

      # @param klass [Class]
      # @param array [Array]
      # @return [Array]
      def objects_from_array(klass, array)
        array.map { |element| klass.new element }
      end
    end
  end
end
