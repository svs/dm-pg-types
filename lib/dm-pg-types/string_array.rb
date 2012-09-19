require 'dm-core'

module DataMapper
  class Property
    class StringArray < PgArray
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
    end # class StringArray
  end # class Property
end # module DataMapper
