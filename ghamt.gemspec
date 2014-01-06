# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ghamt/version'

Gem::Specification.new do |spec|
  spec.name          = "ghamt"
  spec.version       = Ghamt::VERSION
  spec.authors       = ["Joao Santos"]
  spec.email         = ["joao.santos@kitanda.co.uk"]
  spec.summary       = %q{GitHub Asset Management Toolkit}
  spec.description   = %q{ghAMT provides a set of ruby scripts able to manipulate release assets, namely packaged builds that are created through CI.}
  spec.homepage      = "http://www.kitanda.co.uk"
  spec.license       = "LGPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
