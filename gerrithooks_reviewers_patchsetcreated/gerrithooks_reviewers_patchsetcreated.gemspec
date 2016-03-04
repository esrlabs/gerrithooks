# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gerrithooks_reviewers_patchsetcreated/version'

Gem::Specification.new do |spec|
  spec.name          = "gerrithooks_reviewers_patchsetcreated"
  spec.version       = GerrithooksReviewersPatchsetcreated::VERSION
  spec.authors       = ["Christian Köstlin"]
  spec.email         = ["christian.koestlin@esrlabs.com"]

  spec.summary       = %q{gerrithooks plugins that automatically adds suitable reviewers to a patchset.}
  spec.description   = %q{}
  spec.homepage      = "https://www.esrlabs.com"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

spec.add_development_dependency "bundler", "~> 1.11"
spec.add_development_dependency "rake", "~> 10.0"
spec.add_development_dependency "rspec", "~> 3.0"
end
