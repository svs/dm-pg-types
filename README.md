# dm-pg-types

# Installation

dm-pg-types is available as a RubyGem. Simply put this in your Gemfile

```
gem 'dm-pg-types'
```

and you should be good to go.

DataMapper plugin providing support for PostgreSQL's HSTORE and ARRAY types. An example will suffice

```ruby
DataMapper.setup(:default, 'postgres://svs@localhost/dm_pg_types_person')
DataMapper.repository(:default).adapter.execute("DROP TABLE IF EXISTS people")
DataMapper.repository(:default).adapter.execute("CREATE EXTENSION HSTORE")

class Person
  include DataMapper::Resource
      
  property :id,        Serial
  property :name,      String
  property :info,      HStore
  property :decimals,  DecimalArray, :scale => 5, :precision => 10
end
    
DataMapper.finalize
DataMapper.auto_migrate!
    
p = Person.new
p.info = {:a => "b", :c => "d"}
p.decimals = [10.1, 11.2]
p.save

```

Thanks to https://github.com/softa/activerecord-postgres-hstore for doing most of the heavy lifting

