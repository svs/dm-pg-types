require 'spec_helper'

try_spec do

  require './spec/fixtures/person'

  describe DataMapper::TypesFixtures::Person do
    supported_by :all do
      before :all do
        @resource = DataMapper::TypesFixtures::Person.new(:name => '')
      end

      describe 'with no other information' do
        before :all do
          @resource.favorite_numbers = nil
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'has no favorite_numbers' do
            @resource.favorite_numbers.should == nil
          end
        end
      end

      describe 'with no favorite_numbers information' do
        before :all do
          @resource.favorite_numbers = []
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'has empty favorite_numbers list' do
            @resource.favorite_numbers.should == []
          end
        end
      end

      describe 'with a few items on the favorite_numbers list' do
        before :all do
          @input = [10,11,12]
          @resource.favorite_numbers = @input
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'includes "fire" in favorite_numbers' do
            @resource.favorite_numbers.should  == [10,11,12]
          end

        end
      end
    end
  end
end
