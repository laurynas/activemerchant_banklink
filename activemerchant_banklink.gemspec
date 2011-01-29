# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "activemerchant_banklink/version"

Gem::Specification.new do |s|
  s.name        = "activemerchant_banklink"
  s.version     = ActivemerchantBanklink::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Indrek Juhkam", "Laurynas Butkus"]
  s.email       = ["laurynas.butkus@gmail.com"]
  s.homepage    = "http://github.com/laurynas/activemerchant_banklink"
  s.summary     = %q{ActiveMerchant Banklink add-on (alpha version)}
  s.description = %q{Adds Banklink support to ActiveMerchant library. Banklink is provided by major banks in the Baltic states.}

  s.rubyforge_project = "activemerchant_banklink"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
