require 'dawn/api/authenticate'
require 'json'

module Dawn
  module BaseApi
    module RequestExtension
      def request(options)
        options[:expects] = 200 unless options.key?(:expects)
        JSON.load Dawn.request(options).body
      end

      [:get, :post, :put, :patch, :delete].each do |key|
        define_method(key) { |options| request options.merge(method: key) }
      end
    end

    module ClassExtension
      include RequestExtension

      def id_param(options)
        options.delete(:id)
      end

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

        return key_name
      end
    end

    def self.included(mod)
      mod.extend ClassExtension
    end

    include RequestExtension
  end
end
