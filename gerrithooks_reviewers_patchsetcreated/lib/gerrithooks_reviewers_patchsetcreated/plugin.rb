def run(args, io)
  require 'set'
  io.puts "Running auto add reviewers"

  commit = args['--commit']
  raise 'missing commit' unless commit

  project = args['--project']
  raise 'missing project' unless project

  touched_files = `git diff-tree --no-commit-id --name-only -r #{commit}`.split("\n")
  blames = touched_files.map{|file| `git blame -e #{commit} -- #{file}` }
  emails = Set.new(blames.map {|l| l.to_enum(:scan, /^\w* \(<(.*@.*)>/).map { Regexp.last_match[1].strip }}.flatten)

  puts "adding reviewers #{emails.to_a.join(' ')}"

  add_reviewers = emails.map{|email|"-a #{email}"}.join(' ')
  sh("ssh gerrit gerrit set-reviewers --project #{project} #{add_reviewers} #{commit}")
end
