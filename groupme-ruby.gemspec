# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'groupme/version'

Gem::Specification.new do |spec|
  spec.name          = "groupme-ruby"
  spec.version       = Groupme::VERSION
  spec.authors       = ["Matthew Perry"]
  spec.email         = ["muffinman616@gmail.com"]
  spec.description   = %q{Ruby gem for the GroupMe v3 API}
  spec.summary       = %q{Ruby gem for the GroupMe v3 API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "her"
  spec.add_dependency "faraday_middleware"
end
