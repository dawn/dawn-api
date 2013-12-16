#
# dawn/dawn-api.gemspec
#
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'dawn/api/version'

Gem::Specification.new do |s|
  s.name        = "dawn-api"
  s.homepage    = 'http://anzejagodic.com:5000/'
  s.version     = Dawn::Api::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Dawn API"
  s.date        = Time.now.to_date.to_s

  s.authors = ["Blaž Hrastnik", "Corey Powell"]

  s.add_runtime_dependency "commander"
  s.add_runtime_dependency "excon"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "netrc"

  s.require_path = "lib"
  s.files = ["lib/dawn/api.rb"] +
            Dir.glob("lib/dawn/api/**/*")
end