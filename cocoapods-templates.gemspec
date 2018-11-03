# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-templates/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-templates'
  spec.version       = CocoapodsTemplates::VERSION
  spec.authors       = ['Oliver Letterer']
  spec.email         = ['oliver.letterer@gmail.com']
  spec.description   = %q{Cocoapods plugin to install Xcode templates from a remote source}
  spec.summary       = %q{Cocoapods plugin to install Xcode templates from a remote source}
  spec.homepage      = 'https://github.com/objc-pieces/cocoapods-templates'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'git', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
