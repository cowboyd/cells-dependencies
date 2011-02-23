# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cell/dependencies/version"

Gem::Specification.new do |s|
  s.name        = "cell-dependencies"
  s.version     = Cell::Dependencies::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Charles Lowell"]
  s.email       = ["cowboyd@thefrontside.net"]
  s.homepage    = "http://github.com/cowboyd/cell-dependencies"
  s.summary     = "Say which cells depend on other cells"
  s.description = "Sometimes its useful to know which cells depend on each other before you actually render them"

  s.rubyforge_project = "cell-dependencies"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "cells", ">= 3.5.0"
  
  s.add_development_dependency "rspec", ">= 2.0.0"
end
