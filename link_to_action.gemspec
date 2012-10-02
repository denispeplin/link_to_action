$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "link_to_action/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "link_to_action"
  s.version     = LinkToAction::VERSION
  s.authors     = ["denispeplin"]
  s.email       = ["denis.peplin@gmail.com"]
  s.homepage    = "https://github.com/denispeplin/link_to_action"
  s.summary     = "Links to actions"
  s.description = "link_to for specific actions"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rails", "~> 3.2.8"
end
