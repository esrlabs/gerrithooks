require 'gerrithooks_reviewers_patchsetcreated'
def sh(command)
  puts "running comand '#{command}'"
end
args = {'--commit' => '50d4c795e0ce3e2fe99cea38e157b5a2ac76f378', '--project' => '1234'}
run(args, STDOUT)
