# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slayer_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'slayer_rails'
  spec.version       = SlayerRails::VERSION
  spec.authors       = ['Wyatt Kirby']
  spec.email         = ['wyatt@apsis.io']

  spec.summary       = 'Rails extensions for Slayer.'
  spec.homepage      = 'http://www.apsis.io'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rails', '>= 4.2.0'
  spec.add_runtime_dependency 'slayer', '>= 0.5.0.beta'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rubocop', '= 1.38.0'
end
