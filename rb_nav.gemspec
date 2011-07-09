# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rb_nav/version"

Gem::Specification.new do |s|
  s.name        = "rb_nav"
  s.version     = RbNav::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.8.6'

  s.authors     = ["Daniel Choi"]
  s.email       = ["dhchoi@gmail.com"]
  s.homepage    = "http://danielchoi.com/software/rb_nav.html"
  s.summary     = %q{Browse Ruby documentation in Vim}
  s.description = %q{Browse Ruby documentation in Vim}

  s.rubyforge_project = "rb_nav"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  message = "* Now please run rb_nav_install to install the Vim plugin *"
  divider = "*" * message.length 
  s.post_install_message = [divider, message, divider].join("\n")

end

