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
          @resource.other_information = nil
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'has no other_information' do
            @resource.other_information.should == {}
          end
        end
      end

      describe 'with no other_information information' do
        before :all do
          @resource.other_information = {}
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'has empty other_information list' do
            @resource.other_information.should == {}
          end
        end
      end

      describe 'with a few items on the other_information list' do
        before :all do
          @input = {:a => 'b', :c => 'd'}
          @resource.other_information = @input
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'includes "fire" in other_information' do
            @resource.other_information.keys.should include("a")
          end

          it 'has blank entries removed' do
            @resource.other_information.any? { |i| DataMapper::Ext.blank?(i) }.should be(false)
          end
        end
      end
    end
  end
end
