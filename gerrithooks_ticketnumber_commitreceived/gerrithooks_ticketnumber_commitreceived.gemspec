# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gerrithooks_ticketnumber_commitreceived/version'

Gem::Specification.new do |spec|
  spec.name          = "gerrithooks_ticketnumber_commitreceived"
  spec.version       = GerrithooksTicketnumberRefupdate::VERSION
  spec.authors       = ["Arthur Alfredo"]
  spec.email         = ["arthur.braga@esrlabs.com"]

  spec.summary       = %q{plugin to gerrithooks that ensures that a ticket number is present in the commit message.}
  spec.description   = %q{.}
  spec.homepage      = "https://github.com/esrlabs/gerrithooks/tree/master/gerrithooks_ticketnumber_refupdate"

  spec.files         = Dir.glob("lib/**/*.rb")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "gerrithooks"
  spec.add_dependency "git"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
