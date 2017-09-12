require 'spec_helper'

describe GerrithooksReviewersPatchsetcreated do

  it 'has a version number' do
    expect(GerrithooksReviewersPatchsetcreated::VERSION).not_to be nil
  end

  it 'must remove info@esrlabs.com from the reviewers' do
    reviewers = ['info@esrlabs.com', 'christian.koestlin@esrlabs.com']
    expect(filter_reviewers(reviewers)).to eq(['christian.koestlin@esrlabs.com'])
  end

  it 'must produce a nice set of reviewers for a change' do
    require 'fileutils'
    def sh(command)
      res = `#{command}`
      exit_status = $?.exitstatus
      if exit_status != 0
        raise "'#{command}' exited with #{exit_status}"
      end
      return res
    end

    def ssh_gerrit(command)
      return "" if command.include?('set-reviewers')
      return sh("ssh gerrit gerrit #{command}")
    end

    FileUtils.cd '..' do
      args = {}
      args["--commit"] = 'cc4c25d3c2831530870d026ce5e80af2a4b87a4a'
      args["--project"] = 'whatever'
      io = StringIO.new
      run(args, io)
      expect(io.string).to include("adding reviewers christian.koestlin@esrlabs.com\n")
    end
  end

end
