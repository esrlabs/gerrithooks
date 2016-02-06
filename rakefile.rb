require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'assemble'
task :assemble do
  Dir.glob('**/rakefile.rb').each do |rakefile|
    cd File.dirname(rakefile) do
      sh "rake clean install"
    end
  end
end
