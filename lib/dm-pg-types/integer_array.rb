require 'dm-core'

module DataMapper
  class Property
    class IntegerArray < PgArray
      def initialize(model, name, options = {})
        super
      end

      def load(value)
        super.map(&:to_i) if value
      end
    end # class IntegerArray
  end # class Property
end # module DataMapper
