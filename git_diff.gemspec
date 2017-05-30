# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_diff/version'

Gem::Specification.new do |spec|
  spec.name          = "git_diff"
  spec.version       = GitDiff::VERSION
  spec.authors       = ["Andrew Olson"]
  spec.email         = ["anolson@gmail.com"]
  spec.summary       = %q{A Ruby library for parsing git diffs.}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
