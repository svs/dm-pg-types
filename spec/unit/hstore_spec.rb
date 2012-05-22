require 'spec_helper'

try_spec do
  describe DataMapper::Property::HStore do
    supported_by :all do
      before :all do
        class User
          include DataMapper::Resource
          property :id, Serial
          property :doc, HStore
        end

        @property = User.properties[:doc]
      end
      
      describe '.load' do
        describe "argument is a string that is an hstore document" do
          before :all do
            @input = '"branch_id"=>"3", "center_id"=>"5", "client_id"=>"4"'
            @result = @property.load(@input)
          end
          
          it "parses the input into a hash" do
            @result.should == {"branch_id" => "3", "center_id" => "5", "client_id" => "4"}
          end

          it "should read NULLs properly" do
            @property.load('"a" => "3", "b" => "NULL"').should == {"a" => "3", "b" => nil}
          end
        end
      end
      
      describe ".dump" do
        before :all do
          @input = {:a => 1, :b => "def"}
          @result = @property.dump(@input)
        end
        
        describe "when argument is a Hash" do
          it "should result in a Hashified string" do
            @result.should == 'a => 1,b => def'
          end

          it "should write a nil as NULL" do
            @property.dump({:a => 1, :b => nil}).should == 'a => 1,b => NULL'
          end

        end
      end
          


    end
  end
end
