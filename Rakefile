require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc 'Checking style offences'
task :rubocop do
  sh 'rubocop --format simple || true'
end

task default: %i[rubocop spec]
