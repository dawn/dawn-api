require 'dawn/api/base_api'

module Dawn #:nodoc:
  class Account #:nodoc:
    include BaseApi

    # @type [String]
    data_key :id, write: false
    # @type [Integer]
    data_key :created_at, write: false
    # @type [Integer]
    data_key :updated_at, write: false
    # @type [String]
    data_key :username
    # @type [String]
    data_key :email
    # @type [String]
    data_key :api_key, write: false

    ###
    # @param [Hash] data
    ###
    def initialize(data)
      @data = data
    end

    ###
    # @param [Hash] options
    # @return [self]
    ###
    def refresh(options={})
      @data = get(
        path: "/account",
        query: options
      )["user"]
      self
    end

    ###
    # @param [Hash] options
    # @return [self]
    ###
    def update(options={})
      options.fetch(:account)

      @data = patch(
        path: "/account",
        body: options.to_json
      )["user"]
      self
    end

    ###
    # Using the currently stored @data, #update self
    # @return [self]
    ###
    def save
      update(account: @data)
    end

    ###
    # @param [Hash] data
    # @return [Dawn::Account]
    ###
    def self.current(options={})
      new get(
        path: "/account",
        query: options
      )["user"]
    end
  end
end
