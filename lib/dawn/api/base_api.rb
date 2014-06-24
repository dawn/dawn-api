require 'dawn/api/authenticate'
require 'dawn/api/safe/base_api'
require 'json'

module Dawn #:nodoc:
  module BaseApi #:nodoc:
    ###
    # Base request extension module
    ###
    module RequestExtension
      ###
      # Wrapper function around Dawn.request
      # @param [Hash] options
      ###
      def request(options)
        options[:expects] = 200 unless options.key?(:expects)
        JSON.load Dawn.request(options).body
      end

      [:get, :post, :put, :patch, :delete].each do |key|
        define_method(key) { |options| request options.merge(method: key) }
      end
    end

    module ClassExtension #:nodoc:
      include RequestExtension

      ###
      # Strips a valid id parameter from the given options.
      # This method is normally overwritten in each subclass to suite their
      # id needs.
      # @param [Hash] options
      # @return [String]
      ###
      def id_param(options)
        options.delete(:id)
      end

      ###
      # @return [Array]
      ###
      def data_keys
        @data_keys ||= []
      end

      ###
      # Defines accessor for an internal @data Hash.
      # Methods defined are (key_name) and (key_name)=
      # @param [Symbol] key_name
      # @param [Hash] options
      ###
      def data_key(key_name, options={})
        options = { write: true, read: true, path: key_name }.merge(options)
        key_path = options.fetch(:path)

        route = key_path.to_s.split("/")
        route_dp = route.dup
        last_key = route_dp.pop

        define_method(key_name) do
          route.inject(@data) { |d, key| d[key] }
        end if options.fetch(:read)
        define_method(key_name.to_s+"=") do |v|
          route_dp.inject(@data) { |d, key| d[key] }[last_key] = v
        end if options.fetch(:write)

        data_keys.push(key_name)

        return key_name
      end
    end

    # :nodoc:
    def self.included(mod)
      mod.extend ClassExtension
    end

    include RequestExtension

    ###
    # Generates a Hash from the data_keys
    # @return [Hash]
    ###
    def to_h
      self.class.data_keys.each_with_object({}) do |key, hash|
        hash[key] = send(key) if respond_to?(key)
      end
    end
  end
end
