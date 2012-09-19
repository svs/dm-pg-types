require 'dm-core'
require 'dm-migrations'
require 'dm-types'
require 'dm-postgres-adapter'

module DataMapper
  class Property
    autoload :PgArray,            'dm-pg-types/pg_array'
    autoload :HStore,             'dm-pg-types/hstore'
    autoload :DecimalArray,       'dm-pg-types/decimal_array'
    autoload :StringArray,        'dm-pg-types/string_array'
  end

  module Migrations
    module PostgresAdapter
      def property_schema_hash(property)
        schema = super

        if property.kind_of?(Property::DecimalArray)
          schema[:primitive] = "#{schema[:primitive]}(#{property.precision},#{property.scale})[]"
          schema[:precision] = schema[:scale] = nil
        elsif property.kind_of?(Property::StringArray)
          schema[:primitive] = "#{schema[:primitive]}(#{property.length})[]"
          schema[:length] = nil
        end

        schema
      end
    end
  end

  module PgTypes
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      # Types for PostgreSQL databases.
      #
      # @return [Hash] types for PostgreSQL databases.
      #
      # @api private
      def type_map
        super.merge(
                    Property::HStore => {:primitive => 'HSTORE'},
                    Property::DecimalArray => {:primitive => "NUMERIC"},
                    Property::StringArray => {:primitive => "VARCHAR"}
                    ).freeze
      end
    end
  end
end

DataMapper::Adapters::PostgresAdapter.send(:include,DataMapper::PgTypes)
