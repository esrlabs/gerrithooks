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

desc 'package'
task :package do
  run_rakefiles('clean package')
end

desc 'install_packages'
task :install_packages do
  run_rakefiles('install')
end

