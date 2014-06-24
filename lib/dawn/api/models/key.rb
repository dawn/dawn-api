require 'dawn/api/base_api'

module Dawn #:nodoc:
  class Key #:nodoc:
    include BaseApi

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

    ###
    # @param [Hash] data
    ###
    def initialize(data)
      @data = data
    end

    ###
    # @return [Void]
    ###
    def destroy(options={})
      self.class.destroy(options.merge(id: id))
    end

    ###
    # @param [Hash] options
    # @return [Dawn::Key]
    ###
    def self.create(options={})
      options.fetch(:key)

      new post(
        path: '/account/keys',
        body: options.to_json
      )["key"]
    end

    ###
    # @param [Hash] options
    # @return [Array<Dawn::Key>]
    ###
    def self.all(options={})
      get(
        path: '/account/keys',
        query: options
      ).map { |hsh| new hsh["key"] }
    end

    ###
    # @param [Hash] options
    # @return [Dawn::Key]
    ###
    def self.find(options={})
      id = id_param(options)

      new get(
        path: "/account/keys/#{id}",
        query: options
      )["key"]
    end

    ###
    # @return [Void]
    ###
    def self.destroy(options={})
      id = id_param(options)

      delete(
        path: "/account/keys/#{id}",
        query: options
      )
    end
  end
end
