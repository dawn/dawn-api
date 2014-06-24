$:.unshift(File.expand_path("../lib", File.dirname(__FILE__)))
require "rspec"
require "rspec/expectations"
require "dawn/api"
require "ostruct"
require "yaml"

$test_store = OpenStruct.new
$test_store.ref = YAML.load_file(File.expand_path("references/data.yml", File.dirname(__FILE__)))

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.formatter = :documentation
  config.tty = true
end
