# frozen_string_literal: true

require_relative "lib/omniauth-layers/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-layers"
  spec.version = Omniauth::Layers::VERSION
  spec.authors = ["Victor Verdan"]
  spec.email = ["victorverd@hotmail.com"]

  spec.summary = "Layers OAuth2 strategy for Omniauth"
  spec.homepage = "https://github.com/jamijami00/omniauth-layers"
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jamijami00/omniauth-layers"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency  "omniauth", "~> 2.0"
  spec.add_runtime_dependency  "omniauth-oauth2", "~> 1.8"
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
end
