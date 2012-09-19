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
          @resource.aliases = nil
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'has no aliases' do
            @resource.aliases.should == nil
          end
        end
      end

      describe 'with no aliases information' do
        before :all do
          @resource.aliases = []
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'has empty aliases list' do
            @resource.aliases.should == []
          end
        end
      end

      describe 'with a few items on the aliases list' do
        before :all do
          @input = ['Bob','George','Michael']
          @resource.aliases = @input
        end

        describe 'when dumped and loaded again' do
          before :all do
            @resource.save.should be(true)
            @resource.reload
          end

          it 'includes saved aliases' do
            @resource.aliases.should  == ['Bob','George','Michael']
          end

        end
      end
    end
  end
end
