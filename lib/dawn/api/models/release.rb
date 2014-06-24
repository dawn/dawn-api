require 'dawn/api/base_api'

module Dawn #:nodoc:
  class Release #:nodoc:
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
    data_key :image, write: false
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
        path: "/releases/#{id}",
        query: options
      )["release"]
      self
    end

    ###
    # @param [Hash] options
    # @return [Array<Dawn::Release>]
    ###
    def self.all(options={})
      get(
        path: "/releases",
        query: options
      ).map { |hsh| new hsh["release"] }
    end

    ###
    # @param [Hash] options
    # @return [Dawn::Release]
    ###
    def self.find(options={})
      id = id_param(options)

      new get(
        path: "/releases/#{id}",
        query: options
      )["release"]
    end
  end
end
