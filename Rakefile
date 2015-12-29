require 'bundler/setup'

desc 'check Ruby code style with rubocop'
task :rubocop do
  sh 'rubocop . --format progress --format offenses'
end

desc 'run foodcritic lint checks'
task :foodcritic do
  sh 'foodcritic -f any .'
end

desc 'run chefspec examples'
task :chefspec do
  sh 'rspec --format doc --color'
end

desc 'run test-kitchen integration tests'
task :integration do
  sh 'kitchen test --log-level info'
end

desc 'run all unit-level tests'
task :unit => [:rubocop, :foodcritic, :chefspec]
