# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "git_diff/version"

Gem::Specification.new do |spec|
  spec.name          = "git_diff"
  spec.version       = GitDiff::VERSION
  spec.authors       = ["Andrew Olson"]
  spec.email         = ["anolson@gmail.com"]
  spec.summary       = "A Ruby library for parsing git diffs."
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($RS)
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
end
