# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "watir-webdriver-rails/version"

Gem::Specification.new do |s|
  s.name        = "watir-webdriver-rails"
  s.version     = WatirWebdriverRails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tanin Na Nakorn"]
  s.email       = ["tanin47@gmail.com"]
  s.homepage    = "http://github.com/tanin47/watir-webdriver-rails"
  s.summary     = %q{Watir on WebDriver for Rails}
  s.description = %q{WebDriver-backed Watir for Rails}

  s.rubyforge_project = "watir-webdriver-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "watir-webdriver"
end
