require_relative 'lib/livelist/version'

Gem::Specification.new do |spec|
  spec.name          = 'livelist'
  spec.version       = Livelist::VERSION
  spec.authors       = ['Vitor Roque']
  spec.email         = ['vitor.roquep@gmail.com']

  spec.summary       = %q{A simple gem to manipulate m3u8 files}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/roqueando/livelist'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.glob("{lib,locales}/**/*.*")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
