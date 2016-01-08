# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sommeligem/version'

Gem::Specification.new do |spec|
  spec.name          = "sommeligem"
  spec.version       = Sommeligem::VERSION
  spec.authors       = ["febbraiod"]
  spec.email         = ["donedesign1@gmail.com"]

  spec.summary       = %q{a CLI gem that provides information about the top 100 wines on Wine.com including suggested pairings}
  spec.homepage      = "https://github.com/febbraiod/sommeligem.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["sommeligem"]
  spec.require_paths = ["lib", "lib/sommeligem"]
  

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "open-uri"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "launchy"

end
