# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slayer_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "slayer_rails"
  spec.version       = SlayerRails::VERSION
  spec.authors       = ["Wyatt Kirby"]
  spec.email         = ["wyatt@apsis.io"]

  spec.summary       = %q{Rails extensions for Slayer.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'slayer', '~> 0.2'
  spec.add_runtime_dependency 'rails', '>= 4.2.0'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'appraisal', '~> 2.1'
  spec.add_development_dependency 'byebug', '~> 9.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3'
end
