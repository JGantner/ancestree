# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ancestree/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Julien Gantner"]
  gem.email         = ["julien.gantner@softwareinmotion.de"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "guard-rspec", "~> 1.2.1"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ancestree"
  gem.require_paths = ["lib"]
  gem.version       = Ancestree::VERSION
end
