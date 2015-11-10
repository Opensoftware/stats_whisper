# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stats_whisper/version'

Gem::Specification.new do |spec|
  spec.name          = "stats_whisper"
  spec.version       = StatsWhisper::VERSION
  spec.authors       = ["Michal Pietrus"]
  spec.email         = ["blelump@martex.nom.pl"]
  spec.summary       = %q{A simple middleware to gather metrics and interact with StatsD.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/Opensoftware/stats_whisper"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", " ~> 3.3"

  spec.add_dependency "statsd-ruby", "~> 1.2"
end
