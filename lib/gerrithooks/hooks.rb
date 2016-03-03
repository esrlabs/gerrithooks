# coding: utf-8
require 'frazzle/frazzle'
registry = Frazzle::Registry.new('gerrithooks', '_', '_')

class Hook
  attr_accessor :name
  def intialize(name)
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
    "plugin: #{name} for #{projects_to_string}"
  end
  def projects_to_string
    projects == :all ? 'ALL' : projects.join(', ')
  end
  def sh(command)
    res = `#{command}`
    exit_status = $?.exitstatus
    if exit_status != 0
      raise "'#{command} exited with #{exit_status}"
    end
    return res
  end
end

class PatchsetCreatedHook < Hook
  def intialize(name)
    super(name)
  end
end

class RefUpdateHook < Hook
  def initialize(name)
    super(name)
  end
end

class String
  def indent(spaces)
    split("\n").map{|i|"#{' ' * spaces}#{i}"}.join("\n")
    end
  end


  args = Hash[*ARGV]
project = args['--project']

def run_hooks(hook)
  plugins = registry.plugins(hook.downcase).map do |plugin|
    res = Object::const_get(hook + "Hook").new(plugin.name)
    plugin.load(res)
    res
  end

  plugins.each do |plugin|
    io = StringIO.new
    begin
      if plugin.responsible_for(project)
        plugin.run(args, io)
        puts "OK #{plugin.name}"
        puts io.string.indent(2)
      end
    rescue => error
      puts "FAILED #{plugin.name}"
      puts io.string.indent(2)
      puts error.message
      exit(1)
    end
  end

end

