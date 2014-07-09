# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chgen/version'

Gem::Specification.new do |spec|
  spec.name          = "chgen"
  spec.version       = Chgen::VERSION
  spec.authors       = ["jlupox"]
  spec.email         = ["jlupox@gmail.com"]
  spec.description   = %q{Cheat Sheet generator}
  spec.summary       = %q{utility to create cheat sheets}
  spec.homepage      = "https://github.com/jlupox/chgen"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler" #, "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec" , "~> 2.99.0"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "fakefs"
  # spec.add_development_dependency "debugger"
  # spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-debugger"
  spec.add_development_dependency "ronn"
end
