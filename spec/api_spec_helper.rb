$:.unshift File.expand_path("lib", File.expand_path("../", File.dirname(__FILE__)))
require "dawn/api"
require "ostruct"
require "rspec-expectations"

$test_store = OpenStruct.new
