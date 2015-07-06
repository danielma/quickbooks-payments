# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quickbooks-payments/version'

Gem::Specification.new do |spec|
  spec.name          = "quickbooks-payments"
  spec.version       = Quickbooks::Payments::VERSION
  spec.authors       = ["Daniel Ma"]
  spec.email         = ["drailskid@yahoo.com"]

  spec.summary       = %q{Ruby API for Quickbooks payments}
  spec.description   = %q{Ruby API for Quickbooks payments}
  spec.homepage      = "https://github.com/danielma/quickbooks-payments"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rake", "~> 10.0"
end
