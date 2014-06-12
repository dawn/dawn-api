#
# dawn-api.gemspec
#
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'dawn/api/version'

Gem::Specification.new do |s|
  s.name        = 'dawn-api'
  s.summary     = 'Dawn API'
  s.description = 'Dawn Client API'
  s.homepage    = 'https://github.com/dawn/dawn-api'
  s.version     = Dawn::API::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.date        = Time.now.to_date.to_s
  s.license     = 'MIT'
  s.authors     = ['Blaž Hrastnik', 'Corey Powell']


  s.add_runtime_dependency 'excon',     '~> 0.34'
  s.add_runtime_dependency 'json',      '~> 1.8'
  s.add_runtime_dependency 'netrc',     '~> 0.7'
  s.add_runtime_dependency 'sshkey',    '~> 1.6'

  s.require_path = 'lib'
  s.files = ["README.md", "CHANGELOG.md"] +
            Dir.glob('lib/**/*') +
            Dir.glob('test/**/*')
end
