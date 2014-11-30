Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'activemodel-aggregator'
  s.version       = '0.1.0'
  s.summary       = %q{TODO: Write a short summary. Required.}
  s.description   = %q{TODO: Write a longer description. Optional.}

  s.required_ruby_version = '>= 2.1'

  s.license       = 'MIT'

  s.author       = 'Kasper Timm Hansen'
  s.email        = 'kaspth@gmail.com'
  s.homepage     = 'https://github.com/kaspth/activemodel-aggregator'

  s.files         = Dir['MIT-LICENSE', 'README.md', 'lib/**/*']
  s.require_path = 'lib'

  s.add_runtime_dependency 'activesupport', '4.2.0.rc1'
  s.add_runtime_dependency 'activemodel', '4.2.0.rc1'

  s.add_development_dependency "rake"
end
