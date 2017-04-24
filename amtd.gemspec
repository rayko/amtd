# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amtd/version'

Gem::Specification.new do |spec|
  spec.name          = "amtd"
  spec.version       = Amtd::VERSION
  spec.authors       = ["Rayko"]
  spec.email         = ["rayko.drg@gmail.com"]
  spec.summary       = %q{API Wrapper to use TD AMTD.}
  spec.description   = %q{TD AMTD API provides trading features for users.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"       
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency 'byebug'

  spec.add_dependency "httparty"
  spec.add_dependency "yajl-ruby"
  spec.add_dependency "addressable"

end
