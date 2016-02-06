# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gerrithooks_branchname_refupdate/version'

Gem::Specification.new do |spec|
  spec.name          = "gerrithooks_branchname_refupdate"
  spec.version       = GerrithooksBranchnameRefupdate::VERSION
  spec.authors       = ["Christian Köstlin"]
  spec.email         = ["christian.koestlin@esrlabs.com"]

  spec.summary       = %q{plugin to gerrithooks that checks the branchnames.}
  spec.description   = %q{.}
  spec.homepage      = "http://www.google.com"

  spec.files         = Dir.glob("lib/**/*.rb")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "gerrithooks"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
