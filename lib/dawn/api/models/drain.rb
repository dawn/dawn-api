require 'dawn/api/base_api'

module Dawn #:nodoc:
  class Drain #:nodoc:
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
    # @param [Hash] options
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
        path: "/drains/#{id}",
        query: options
      )["drain"]
      self
    end

    ###
    # @param [Hash] options
    ###
    def destroy(options={})
      Drain.destroy(options.merge(id: id))
    end

    ###
    # @param [Hash] options
    ###
    def self.find(options={})
      id = id_param(options)

      new get(
        path: "/drains/#{id}",
        query: options
      )["drain"]
    end

    ###
    # @param [Hash] options
    ###
    def self.destroy(options={})
      id = id_param(options)

      delete(
        path: "/drains/#{id}",
        query: options
      )
    end
  end
end
