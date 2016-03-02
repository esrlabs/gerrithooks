#!/usr/bin/python
import commands, sys, re
sha1 = filter(lambda a: a[0] == "--commit",zip(sys.argv,sys.argv[1:]))[0][1]
print sha1
project = filter(lambda a: a[0] == "--project", zip(sys.argv, sys.argv[1:]))[0][1]
print project
for f in commands.getoutput("git diff-tree --no-commit-id --name-only -r " + sha1).split("\n"):
    reviewers = set(["-a " + m.group(1) for m in re.finditer(r"^\w* \(<(.*@.*)>", commands.getoutput("git blame -e " + sha1 + " -- " + f))])
    print reviewers
    command = "ssh gerrit gerrit set-reviewers --project " + project + " " + " ".join(reviewers) + " " + sha1
    print command
    commands.getoutput(command)
