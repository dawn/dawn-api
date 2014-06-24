require 'dawn/api/base_api'

module Dawn #:nodoc:
  class Domain #:nodoc:
    include BaseApi

    # @type [Dawn::App]
    attr_writer :app
    # @type [String]
    data_key :id, write: false
    # @type [Integer]
    data_key :created_at, write: false
    # @type [Integer]
    data_key :updated_at, write: false
    # @type [String]
    data_key :url, write: false
    # @type [String]
    data_key :app_id, path: "app/id", write: false

    ###
    # @param [Hash] data
    ###
    def initialize(data)
      @app = nil
      @data = data
    end

    ###
    # @return [Dawn::App]
    ###
    def app
      @app ||= App.find(id: app_id)
    end

    ###
    # @return [self]
    ###
    def refresh
      @data = get(
        path: "/domains/#{id}",
        query: options
      )["domain"]
      self
    end

    ###
    # @param [Hash] options
    # @return [Void]
    ###
    def destroy(options={})
      self.class.destroy(options.merge(id: id))
    end

    ###
    # @param [Hash] options
    ###
    def self.id_param(options)
      id = options.delete(:id) ||
      options.delete(:name) ||
      options.delete(:uri) ||
      options.delete(:url) ||
      raise
    end

    ###
    # @param [Hash] options
    ###
    def self.find(options)
      id = id_param(options)

      new get(
        path: "/domains/#{id}",
        query: options
      )["domain"]
    end

    ###
    # @param [Hash] options
    ###
    def self.destroy(options)
      id = id_param(options)

      delete(
        path: "/domains/#{id}",
        query: options
      )
    end
  end
end
