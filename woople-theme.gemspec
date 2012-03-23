$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "woople-theme/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "woople-theme"
  s.version     = WoopleTheme::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of WoopleTheme."
  s.description = "TODO: Description of WoopleTheme."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  s.add_dependency "less-rails-bootstrap"

  s.add_development_dependency "sqlite3"
end
