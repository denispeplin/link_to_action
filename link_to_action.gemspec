# -*- encoding: utf-8 -*-
require File.expand_path('../lib/link_to_action/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["denispeplin"]
  gem.email         = ["denis.peplin@gmail.com"]
  gem.description   = %q{link_to for specific actions}
  gem.summary       = %q{Links to actions}
  gem.homepage      = "https://github.com/denispeplin/link_to_action"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "link_to_action"
  gem.require_paths = ["lib"]
  gem.version       = LinkToAction::VERSION
end
