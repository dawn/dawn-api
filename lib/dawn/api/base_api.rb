require 'dawn/api/authenticate'
require 'json'

module Dawn
  module BaseApi
    module RequestExtension
      def json_request(options)
        JSON.load request(options).body
      end

      def request(options)
        Dawn.request options
      end
    end

    module Extension
      include RequestExtension

      def data_key(key_name, key_path=key_name)
        route = key_path.to_s.split("/")
        route_dp = route.dup
        last_key = route_dp.pop

        define_method(key_name) do
          route.inject(@data) { |d, key| d[key] }
        end
        define_method(key_name.to_s+"=") do |v|
          route_dp.inject(@data) { |d, key| d[key] }[last_key] = v
        end
      end
    end

    include RequestExtension

    def self.included(mod)
      mod.extend Extension
    end

  end
end
