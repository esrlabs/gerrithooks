# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gerrithooks/version'

Gem::Specification.new do |spec|
  spec.name          = "gerrithooks"
  spec.version       = Gerrithooks::VERSION
  spec.authors       = ["Christian Köstlin"]
  spec.email         = ["christian.koestlin@esrlabs.com"]

  spec.summary       = %q{base gem for gerrithooks.}
  spec.description   = %q{please extend with plugin gems.}
  spec.homepage      = "http://www.google.com"
  spec.licenses    = ['MIT']

  spec.files         = Dir.glob("lib/**/*.rb") + Dir.glob("bin/**/*")
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "frazzle"
  #  spec.add_dependency "colorize" # colors seem not to work in gerrits messages

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
