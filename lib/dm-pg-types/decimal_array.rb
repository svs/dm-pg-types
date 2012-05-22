require 'dm-core'

module DataMapper
  class Property
    class DecimalArray < Object
      accept_options :precision, :scale, :min, :max
      attr_reader :precision, :scale, :min, :max

      def initialize(model, name, options = {})
        super
        @precision = @options.fetch(:precision)
        @scale     = @options.fetch(:scale)

        unless @precision > 0
          raise ArgumentError, "precision must be greater than 0, but was #{@precision.inspect}"
        end
      end


      def load(value)
        value.gsub(/[{}]/,'').split(",").map(&:to_f) if value
      end

      def dump(value)
        "{#{value.join(",")}}" if value
      end
    end # class DecimalArray
  end # class Property
end # module DataMapper
