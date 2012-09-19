require 'rubygems'
require 'rake'

begin
  gem 'jeweler', '~> 1.8.4'
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'dm-pg-types'
    gem.summary     = 'DataMapper plugin providing HSTORE and ARRAY datatype support for postgres'
    gem.description = gem.summary
    gem.email       = 'svs [a] svs [d] io'
    gem.homepage    = 'http://github.com/svs/%s' % gem.name
    gem.authors     = [ 'svs' ]
    gem.has_rdoc    = 'yard'

    gem.rubyforge_project = 'dm-pg-types'
    
    gem.add_dependency 'data_mapper', '~> 1.2.0'	
    gem.add_dependency 'dm-postgres-adapter', '~> 1.2.0'	
    
    gem.version = "0.8.2"
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler -v 1.6.4'
end
