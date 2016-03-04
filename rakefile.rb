require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

def run_rakefiles(command)
  Dir.glob('**/rakefile.rb').each do |rakefile|
    cd File.dirname(rakefile) do
      sh "rake #{command}"
    end
  end
end

desc 'build gems'
task :build_gems do
  run_rakefiles('clean build')
end

desc 'install_gems'
task :install_gems do
  run_rakefiles('install')
end

