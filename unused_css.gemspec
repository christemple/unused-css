# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unused_css/version'

Gem::Specification.new do |spec|
  spec.name          = "unused_css"
  spec.version       = UnusedCSS::VERSION
  spec.authors       = ["Chris Temple"]
  spec.email         = ["temple3188@gmail.com"]
  spec.description   = %q{A Ruby gem, built from a need, to watch a suite of functional tests and gather all of the unused CSS styles.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/christemple/unused-css"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "css_parser"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sinatra"
  spec.add_development_dependency "thin"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "watir-webdriver"
end
