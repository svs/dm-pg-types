require 'spec_helper'

try_spec do
  describe DataMapper::Property::IntegerArray do
    supported_by :all do
      before :all do
        class User
          include DataMapper::Resource
          property :id, Serial
          property :things, IntegerArray
        end

        @property = User.properties[:things]
      end
      
      describe '.load' do
        describe "argument is a string that is a decimal array" do
          before :all do
            @input = '{10,2.2,4,5,6}'
            @result = @property.load(@input)
          end
          
          it "parses the input into an integer array" do
            @result.should == [10,2,4,5,6]
          end
        end
        describe "argument is a string that is a integer array" do
          before :all do
            @input = '{10,1,4,5,6}'
            @result = @property.load(@input)
          end
          
          it "parses the input into an integer array" do
            @result.should == [10,1,4,5,6]
          end
        end
      end
      
      describe ".dump" do
        before :all do
          @input = [1,2,3,5,6]
          @result = @property.dump(@input)
        end
        
        describe "when argument is a Hash" do
          it "should result in a postgres array string" do
            @result.should == '{1,2,3,5,6}'
          end
        end
      end
    end
  end
end
