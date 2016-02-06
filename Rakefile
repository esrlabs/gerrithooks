require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'assemble'
task :assemble do
  sh "rake install"
  cd "gerrithooks_branchname_refupdate" do
    sh "rake install"
  end
end
