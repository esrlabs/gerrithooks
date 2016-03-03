# coding: utf-8
require 'git'

def run(args, io)
  branch_names = Git.bare('.').branches.map{|i|i.full}
  refname = args['--refname'].gsub('refs/heads/', '')

  return if branch_names.include?(refname)

  conflicting_branch = branch_names.find{|i|i.casecmp(refname) == 0}
  return unless conflicting_branch

  raise "'#{conflicting_branch}' conflicts with '#{refname}'"
end
