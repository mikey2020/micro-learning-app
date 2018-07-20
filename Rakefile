require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'rake'
require 'rspec/core/rake_task'
require 'coveralls/rake/task'
require './app'

desc 'Run RSpec'
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
end
task default: :spec
Coveralls::RakeTask.new
