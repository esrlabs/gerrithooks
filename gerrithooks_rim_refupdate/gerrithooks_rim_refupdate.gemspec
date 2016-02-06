# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gerrithooks_rim_refupdate/version'

Gem::Specification.new do |spec|
  spec.name          = "gerrithooks_rim_refupdate"
  spec.version       = GerrithooksRimRefupdate::VERSION
  spec.authors       = ["Christian Koestlin"]
  spec.email         = ["christian.koestlin@esrlabs.com"]

  spec.summary       = %q{gerrithook that checks with rim.}
  spec.description   = %q{}
  spec.homepage      = "http://www.esrlabs.com"
  spec.license       = "MIT"

  spec.files         = Dir.glob('lib/**/*.rb')
  spec.require_paths = ["lib"]

  spec.add_dependency "gerrithooks"
  spec.add_dependency "esr-rim"
  
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
