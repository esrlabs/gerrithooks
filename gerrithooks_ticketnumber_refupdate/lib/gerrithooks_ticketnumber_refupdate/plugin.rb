# coding: utf-8
require 'git'

def projects
  [
    'ssg2021/E_esrl_ar_stack',
    'hkfm2021/E_esrl_ar_stack'
  ]
end

def branches
  { 
    'ssg2021/E_esrl_ar_stack' => ['esrdev', 'esrmaster'],
    'hkfm2021/E_esrl_ar_stack' => ['esrdev', 'esrmaster']
  }
end

def run(args, io)
  commit = `git log --format=%B -n 1 "#{args['--newrev']}"`

  if branches[args['--project']]
    branch = args['--refname'].gsub('refs/for/', '').gsub('refs/heads/', '')
    return unless branches[args['--project']].include?(branch)
  end

  return if /^\[?(([A-Z]{3}-[0-9]+)|(no.ticket)(.id)?)\]?/i.match(commit)

  raise <<~ERROR
         Please add a JIRA ticket number to the commit message in the following formats:
         AAA-9999: COMMIT_MESSAGE
         No ticket: COMMIT_MESSAGE
         The first three letters should be the Project abbreviation.
  ERROR
end
