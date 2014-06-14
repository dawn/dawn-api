$:.unshift File.expand_path("lib", File.expand_path("../", File.dirname(__FILE__)))
require "ostruct"
require "dawn/api/safe"
require "rspec-expectations"

$test_store = OpenStruct.new
