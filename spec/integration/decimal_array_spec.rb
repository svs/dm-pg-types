require 'spec_helper'

require 'debugger'
try_spec do

  require './spec/fixtures/person'

  describe DataMapper::TypesFixtures::Person do
    supported_by :all do
      before :all do
        @resource = DataMapper::TypesFixtures::Person.new(:name => '')
      end

      describe 'with no other information' do
        before :all do
          @resource.numbers = nil
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'has no numbers' do
            @resource.numbers.should == nil
          end
        end
      end

      describe 'with no numbers information' do
        before :all do
          @resource.numbers = []
        end

        describe 'when dumped and loaded again' do
          before :all do
            debugger
            @resource.save.should be(true)
            @resource.reload
          end

          it 'has empty numbers list' do
            @resource.numbers.should == []
          end
        end
      end

      describe 'with a few items on the numbers list' do
        before :all do
          @input = [10.1,11.2,12.3]
          @resource.numbers = @input
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'includes "fire" in numbers' do
            @resource.numbers.should  == [10.1,11.2,12.3]
          end

        end
      end
    end
  end
end
