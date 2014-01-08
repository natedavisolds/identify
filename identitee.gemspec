# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'identitee/version'

Gem::Specification.new do |gem|
  gem.name          = "identitee"
  gem.version       = Identitee::VERSION
  gem.authors       = ["Nate Davis Olds"]
  gem.email         = ["nate@davisolds.com"]
  gem.description   = "Identifies and stores instances of a class for later loading"
  gem.summary       = ""
  gem.homepage      = "https://github.com/natedavisolds/identify"
  gem.licenses      = ["MIT"]
  gem.files         = `git ls-files`.split($/)
  gem.executables   = []
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]
end
