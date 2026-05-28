# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "slayer_rails/version"

Gem::Specification.new do |spec|
  spec.name = "slayer_rails"
  spec.version = SlayerRails::VERSION
  spec.authors = ["Wyatt Kirby"]
  spec.email = ["wyatt@apsis.io"]

  spec.summary = "Rails extensions for Slayer."
  spec.homepage = "http://www.apsis.io"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.3.0"

  spec.add_dependency "rails", ">= 7.1.0"
  spec.add_dependency "slayer", ">= 0.5"

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "standard", "~> 1.39"
  spec.metadata["rubygems_mfa_required"] = "true"
end
