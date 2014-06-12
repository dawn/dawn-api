$:.unshift File.expand_path("lib", File.expand_path("../", File.dirname(__FILE__)))
require "dawn/api"
require "rspec-expectations"

def validate(obj, key, options)
  options.each do |validation, value|
    case validation
    when :presence
      assert_true(obj.respond_to?(key))
      if value
        assert_not_nil(obj.send(key))
      else
        assert_nil(obj.send(key))
      end
    end
  end
end
