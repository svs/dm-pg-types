require 'dm-core'

module DataMapper
  class Property
    class DecimalArray < PgArray
      accept_options :precision, :scale, :min, :max
      attr_reader :precision, :scale, :min, :max

      def initialize(model, name, options = {})
        super
        @precision = @options[:precision] || 10
        @scale     = @options[:scale]     || 0

        unless @precision > 0
          raise ArgumentError, "precision must be greater than 0, but was #{@precision.inspect}"
        end
      end


      def load(value)
        super.map(&:to_f) if value
      end
    end # class DecimalArray
  end # class Property
end # module DataMapper
