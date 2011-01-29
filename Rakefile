require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

desc "Run the unit test suite"
task :default => 'test:units'
    
namespace :test do
    
  Rake::TestTask.new(:units) do |t|
    t.pattern = 'test/unit/**/*_test.rb'
    t.ruby_opts << '-rubygems'
    t.libs << 'test'
    t.verbose = true
  end
  
  Rake::TestTask.new(:remote) do |t|
    t.pattern = 'test/remote/**/*_test.rb'
    t.ruby_opts << '-rubygems'
    t.libs << 'test'
    t.verbose = true
  end
  
end

