def projects
  [
    "tools/sim-playground",
    "tools/rim-playground",
    "BmwBDCevo/bdc",
    "BmwILA/cpm",
    "BmwILA/gpm",
    "zgw/zgw2018"
  ]
end

def not_scratch_branch(args)
  !(args['--refname'] && args['--refname'].split('/').last =~ /^scratch_/)
end

def not_sim_user(arg)
  args['--uploader'].strip != "sim"
end

def not_delete_branch_operation(args)
  args['--newrev'] !~ /^0+$/
end

def run(args, io)
  # IMPORTANT: ensure that the sim user name is correct! (i.e. not "sim sim@esrlabs.com", etc)
  if not_scratch_branch(args) && not_sim_user(args) && not_delete_branch_operation(args)
    io.puts "-"
    io.puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # using -f here enables the incremental check
    # this means that only the new commits are checked, not existing ones
    cmd = "#{RIMCmd} status -f --verify-clean --gerrit #{args['--newrev']}"
    io.puts cmd
    io.puts
    io.puts `"#{RIMCmd} --version"`
    io.puts
    io.puts `#{cmd}`
    io.puts
    io.puts "exit status: #{$?.exitstatus}"
    io.puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    if $?.exitstatus != 0
      raise 'rim failed'
    end
  end
end
