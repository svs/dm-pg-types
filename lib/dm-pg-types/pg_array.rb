require 'dm-core'
require 'csv'

module DataMapper
  class Property
    class PgArray < Object
      def load(value)
        CSV.parse_line(value.gsub(/[{}]/,'')) || [] if value
      end

      def dump(value)
        "{#{CSV.generate_line(value, :row_sep => '')}}" if value
      end
    end # class PgArray
  end # class Property
end # module DataMapper
