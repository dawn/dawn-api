require 'dawn/api/base_api'

module Dawn
  class Key
    include BaseApi

    attr_reader :data

    def initialize(data)
      @data = data
    end

    # @type [String]
    data_key :id, write: false
    # @type [Integer]
    data_key :created_at, write: false
    # @type [Integer]
    data_key :updated_at, write: false
    # @type [String]
    data_key :fingerprint, write: false
    # @type [String]
    data_key :key, write: false

    def destroy(options={})
      self.class.destroy(options.merge(id: id))
    end

    def self.create(options={})
      options.fetch(:key)

      new post(
        path: '/account/keys',
        body: options.to_json
      )["key"]
    end

    def self.all(options={})
      get(
        path: '/account/keys',
        query: options
      ).map { |hsh| new hsh["key"] }
    end

    def self.find(options={})
      id = id_param(options)

      new get(
        path: "/account/keys/#{id}",
        query: options
      )["key"]
    end

    def self.destroy(options={})
      id = id_param(options)

      delete(
        path: "/account/keys/#{id}",
        query: options
      )
    end

    class << self
      private :new
    end
  end
end
