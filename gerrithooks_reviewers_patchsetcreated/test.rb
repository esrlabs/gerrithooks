require 'gerrithooks_reviewers_patchsetcreated'
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
args = {'--commit' => '50d4c795e0ce3e2fe99cea38e157b5a2ac76f378', '--project' => '1234'}
run(args, STDOUT)
