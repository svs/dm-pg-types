require 'spec_helper'

describe "dm-pg-types" do
  before :all do
    # Create the table manually before running this spec.
    DataMapper.setup(:default, 'postgres://localhost/dm_pg_types_person')
    DataMapper.repository(:default).adapter.execute("DROP TABLE IF EXISTS people")
    DataMapper.repository(:default).adapter.execute("CREATE EXTENSION HSTORE") rescue nil
    class Person
      include DataMapper::Resource

      property :id, Serial
      property :name, String
      property :info, HStore
      property :decimals, DecimalArray, :scale => 5, :precision => 10
      property :aliases, StringArray, :length => 10
    end

    DataMapper.finalize
    DataMapper.auto_migrate!

    p = Person.new
    p.info = {:a => "b", :c => "d"}
    p.decimals = [10.1, 11.2]
    p.aliases = ["Bob", "George"]
    p.save
    @p = Person.last
  end

  it "should provide a person with info" do
    @p.info.should == {"a" => "b", "c" => "d"}
  end

  it "should provide a person with decimals" do
    @p.decimals.should == [10.1,11.2]
  end

  it "should provide a person with aliases" do
    @p.aliases.should == ['Bob', 'George']
  end

end
