# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'para/stall/version'

Gem::Specification.new do |spec|
  spec.name          = "para-stall"
  spec.version       = Para::Stall::VERSION
  spec.authors       = ["vala"]
  spec.email         = ["gonjo@free.fr"]

  spec.summary       = %q{Integration of Stall e-commerce with Para CMS}
  spec.description   = %q{Includes basic views and fields for manipulating Stall models in Para admin interface}
  spec.homepage      = "https://github.com/para-cms/para-stall"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "stall"
  spec.add_dependency "simple_form"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
