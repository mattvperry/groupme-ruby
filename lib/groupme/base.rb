module GroupMe
  class Base
    class << self
      def from_response(response = {})
        new(response[:body][:data])
      end

      # Define methods that retrieve the vale from attributes
      #
      # @param attrs [Array, Symbol]
      def attr_reader(*attrs)
        attrs.each do |attr|
          define_attribute_method(attr)
          define_predicate_method(attr)
        end
      end

      # Dynamically define a method for an attribute
      #
      # @param key1 [Symbol]
      def define_attribute_method(key1)
        define_method(key1) do
          @attrs[key1]
        end
      end

      # Dynamically define a predicate method for an attribute
      #
      # @param key1 [Symbol]
      # @param key2 [Symbol]
      def define_predicate_method(key1, key2=key1)
        define_method(:"#{key1}?") do
          !!@attrs[key2]
        end
      end
    end

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @return [Twitter::Base]
    def initialize(attrs = {})
      @attrs = attrs
    end
  end
end
