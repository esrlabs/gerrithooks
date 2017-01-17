# coding: utf-8
require 'frazzle/frazzle'

class Hook
  attr_accessor :name
  def initialize(name)
    @name = name
  end
  def run(args, io)
    raise "please implement run in #{self}"
  end
  def projects
    return :all
  end
  def responsible_for(project)
    return true if projects == :all
    return projects.include?(project)
  end
  def to_s
    return "plugin: #{name} for #{projects_to_string}"
  end
  def projects_to_string
    projects == :all ? 'ALL' : projects.join(', ')
  end
  # emulate a better version of rakes sh
  # @return stdout of the command
  # @raise Exception if the command failed
  def sh(command)
    res = `#{command}`
    exit_status = $?.exitstatus
    if exit_status != 0
      raise "'#{command} exited with #{exit_status}"
    end
    return res
  end
  def ssh_gerrit(command)
    return sh("ssh gerrit gerrit #{command}")
  end
end

class String
  def indent(spaces)
    split("\n").map{|i|"#{' ' * spaces}#{i}"}.join("\n")
  end
end

def run_hooks(hook)
  args = Hash[*ARGV]
  project = args['--project']
  raise 'no project given' unless project
  
  registry = Frazzle::Registry.new('gerrithooks', '_', '_')
  plugins = registry.plugins(hook.downcase).map do |plugin|
    res = Hook.new(plugin.name)
    plugin.load(res)
    res
  end

  puts("-")
  plugins.each do |plugin|
    io = StringIO.new
    begin
      if plugin.responsible_for(project)
        plugin.run(args, io)
        # i use ok here instead of a nice
        puts "OK #{plugin.name}"
        # unicode checkmark, because this is lost in the git output
        s = io.string
        begin
          puts s.indent(2) if s.size > 0
        rescue Exception => e
          puts "Problems with indenting: #{s}"
        end  
      end
    rescue => error
      puts "FAILED #{plugin.name}"
      puts io.string.indent(2)
      puts error.message
      exit(1)
    end
  end
end
