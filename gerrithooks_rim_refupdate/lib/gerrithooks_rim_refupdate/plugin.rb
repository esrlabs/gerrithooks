# coding: utf-8
def projects
  [
    "tools/sim-playground",
    "tools/rim-playground",
    "BmwBDCevo/bdc",
    "BmwILA/cpm",
    "BmwILA/gpm",
    "zgw/zgw2018",
    "Audi/GW/v3/Gateway",
    'BmwBCP21/prototype',
    'hkfm2021/SW_bmw_hkfm_sp2021',
    'ssg2021/E_esrl_ar_stack',
  ]
end

def whitelist
  { 'hkfm2021/SW_bmw_hkfm_sp2021' => /^master$|^develop$/,
    'ssg2021/E_esrl_ar_stack'  => /^master$|^develop$/
  }
end

def not_whitelisted(args)
  if (args['--project'])
    p = whitelist.find { |project, wlist| args['--project'].include?(project) }
    if p
      return !(args['--refname'] && args['--refname'].split('/').last =~ p[1])
    end
  end
  return true
end

def not_scratch_branch(args)
  !(args['--refname'] && args['--refname'].split('/').last =~ /^scratch_/)
end

def not_sim_user(args)
  args['--uploader'].strip != "sim (sim@esrlabs.com)"
end

def not_delete_branch_operation(args)
  args['--newrev'] !~ /^0+$/
end

def run(args, io)
  #rim_cmd = "ruby /home/gerrit2/sim/rim/rim.rb"
  # this is the version installed as a gem to the @rim gemset
  rim_cmd = "rim"

  # IMPORTANT: ensure that the sim user name is correct! (i.e. not "sim sim@esrlabs.com", etc)
  if not_whitelisted(args) && not_scratch_branch(args) && not_sim_user(args) && not_delete_branch_operation(args)
    io.puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # using -f here enables the incremental check
    # this means that only the new commits are checked, not existing ones
    cmd = "#{rim_cmd} status -f -d --verify-clean --gerrit #{args['--newrev']}"
    io.puts cmd
    io.puts
    io.puts `#{rim_cmd} --version 2>&1`
    io.puts
    io.puts `#{cmd} 2>&1`
    io.puts
    io.puts "exit status: #{$?.exitstatus}"
    io.puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    if $?.exitstatus != 0
      raise 'rim status failed'
    end
  end
end
