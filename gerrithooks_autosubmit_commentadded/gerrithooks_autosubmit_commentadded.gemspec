
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gerrithooks_autosubmit_commentadded/version"

Gem::Specification.new do |spec|
  spec.name          = "gerrithooks_autosubmit_commentadded"
  spec.version       = GerrithooksAutosubmitCommentadded::VERSION
  spec.authors       = ["Arthur Braga Alfredo"]
  spec.email         = ["arthur.braga@esrlabs.com"]

  spec.summary       = "Auto submit commits if there's an author and non author code review"
  spec.description   = ""
  spec.homepage      = "https://esrlabs.com"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
