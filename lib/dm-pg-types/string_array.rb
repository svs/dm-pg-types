require 'dm-core'

module DataMapper
  class Property
    class StringArray < PgArray
      def initialize(model, name, options = {})
        super
      end
    end # class StringArray
  end # class Property
end # module DataMapper
