require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'jeweler'
require 'rake'



Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "infinispan-ruby-client"
  gem.homepage = "https://github.com/lance/infinispan-ruby-client"
  gem.license = "MIT"
  gem.summary = %Q{Infinispan Hotrod Client}
  gem.description = %Q{infinispan-hotrod-client provides native ruby access to the Infinispan Hotrod API}
  gem.email = "lball@redhat.com"
  gem.authors = ["Lance Ball"]
  gem.files = FileList["[A-Z]*.*", "lib/**/*"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
end
Jeweler::RubygemsDotOrgTasks.new


task :default => :test
task :test => :spec

if !defined?(RSpec)
  puts "spec targets require RSpec"
else
  desc "Run all examples"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/**/*.rb'
    t.rspec_opts = ['-cfs']
  end

end


