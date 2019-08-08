# Gerrithooks

This implements a gem based plugin system for gerrit hooks.

## Installation

Create a gemset, install all your wanted plugins, link from rvm
wrappers to the respective hooks in gerrit/hooks.

I had to create the wrapper for the binaries manually with:
`rvm wrapper 2.4.1@gerrithooks patchset-created` and
`rvm wrapper 2.4.1@gerrithooks ref-updated`.

## Plugin-System

### Base

Plugins are implemented as gems.
Each gem can be used for one gerrit hook.
The gems follow the naming convention
`gerrithooks_functionality_hookname`. E.g. If you want to change
reviewers whenever a changeset is create, create a gem called
`gerrithooks_reviewers_patchsetcreated`.

### Creating a new hook

`bundle gem gerrithook_autosubmit_commentadded`

Remove .git
Adjust .gitignore
Rename Rakefile to rakefile.rb
Implement functionality

### Implementation

Each gem should contain a ruby file called plugin.rb in `gemname`.

In a minimal case you should implement `run(args, io)`.
Args are the commandline arguments to the hook parsed as hash, io is
the output thats put e.g. to the user when he pushed a commit.

Please have a look at the existing gems to get an idea on how to use
the api.

### API available to the plugins

- use sh to run commands (this raises an ruby exception if the command
fails, otherwise it returns the commands output).

- use ssh_gerrit to get a ssh connection to gerrit for issueing
commands.

- Otherwise gems are free to use whatever gems the like. just declare
them in your gemspec. it is up to gem and the maintainer of the gerrit
server to make sure that the gems are available for the plugins. Take
a look at the branchname_refupdate plugin (this uses the ruby git
plugin).
