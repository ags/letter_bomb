$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "letter_bomb/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "letter_bomb"
  s.license     = "MIT"
  s.version     = LetterBomb::VERSION
  s.authors     = ["Alex Smith"]
  s.email       = ["alex@thatalexguy.com"]
  s.homepage    = "https://github.com/ags/letter_bomb"
  s.summary     = "Preview mailer templates in the browser."
  s.description = "Preview mailer templates in the browser."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'factory_girl_rails'
end
