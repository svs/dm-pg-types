module DataMapper
  module TypesFixtures
    class Person
      #
      # Behaviors
      #

      include DataMapper::Resource

      #
      # Properties
      #

      property :id,         Serial
      property :name,       String
      property :other_information, HStore
      property :numbers,    DecimalArray
      property :aliases,    StringArray
      property :favorite_numbers, IntegerArray
    end
  end
end
