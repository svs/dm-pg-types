require 'dm-core'
require 'csv'

module DataMapper
  class Property
    class StringArray < Object
      accept_options :length

      DEFAULT_LENGTH = 50
      length(DEFAULT_LENGTH)

      def length
        if @length.kind_of?(Range)
          @length.max
        else
          @length
        end
      end

      def initialize(model, name, options = {})
        super
        @length = @options.fetch(:length)
      end


      def load(value)
        CSV.parse_line(value.gsub(/[{}]/,'')) || [] if value
      end

      def dump(value)
        "{#{CSV.generate_line(value, :row_sep => '')}}" if value
      end
    end # class StringArray
  end # class Property
end # module DataMapper
