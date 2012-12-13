$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bigos_instagram_box/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bigos_instagram_box"
  s.version     = BigosInstagramBox::VERSION
  s.authors     = ["Artur Kremens"]
  s.email       = ["kremenso@o2.pl"]
  s.homepage    = "weban.com.pl"
  s.summary     = "Instagram box for bigos cms system."
  s.description = "Instagram box module"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  #s.add_dependency "bigos"
  s.add_dependency "instagram"#, :git=>'git://github.com/CamonZ/instagram-ruby-gem.git'
  s.add_dependency "yettings"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
