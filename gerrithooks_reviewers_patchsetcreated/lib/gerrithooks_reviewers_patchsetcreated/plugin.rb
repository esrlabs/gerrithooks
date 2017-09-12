# adds all users that touched the files of the commit to the reviewer list
# the users are checked against known users of gerrit
def excluded_projects
  [
    'bmw/csm4/mainController'
  ]
end

def responsible_for(project)
  return !excluded_projects.include?(project)
end
           
def run(args, io)

  require 'set'
  io.puts "Running auto add reviewers"

  commit = args['--commit']
  raise 'missing commit' unless commit

  project = args['--project']
  raise 'missing project' unless project

  registered_users = Set.new(ssh_gerrit("gsql --format PRETTY -c 'select\\ preferred_email\\ from\\ accounts'").split("\n")[0..-2]
                              .map{|x|x.strip}
                              .delete_if{|x|x=='NULL'})

  touched_files = `git diff-tree --no-commit-id --name-only -r #{commit}`.split("\n")
  blames = touched_files.map{|file| `git blame -e #{commit} -- #{file}` }
  emails = Set.new(blames.map {|l| l.to_enum(:scan, /^\w* \(<(.*@.*)>/).map { Regexp.last_match[1].strip }}.flatten)

  reviewers = emails.intersection(registered_users).to_a
  reviewers = filter_reviewers(reviewers)
  io.puts "adding reviewers #{reviewers.join(' ')}"

  add_reviewers = reviewers.map{|email|"-a #{email}"}.join(' ')
  ssh_gerrit("set-reviewers --project #{project} #{add_reviewers} #{commit}")
end

def filter_reviewers(reviewers)
  reviewers.delete_if{|r|r == "info@esrlabs.com"}
end
