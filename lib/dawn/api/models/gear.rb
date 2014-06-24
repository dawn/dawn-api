require 'dawn/api/base_api'

module Dawn #:nodoc:
  class Gear #:nodoc:
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
    data_key :name, write: false
    # @type [Integer]
    data_key :uptime, write: false
    # @type [String]
    data_key :proctype, write: false
    # @type [Integer]
    data_key :number, write: false
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

    def refresh
      @data = get(
        path: "/gears/#{id}",
        query: options
      )["gear"]
      self
    end

    ###
    # @param [Hash] options
    ###
    def restart(options={})
      self.class.restart(options.merge(id: id))
    end

    ###
    # @param [Hash] options
    ###
    def destroy(options={})
      self.class.destroy(options.merge(id: id))
    end

    ###
    # @param [Hash] options
    ###
    def self.find(options)
      id = id_param(options)

      new get(
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

    ###
    # @param [Hash] options
    ###
    def self.restart(options)
      id = id_param(options)

      post(
        path: "/gears/#{id}/restart",
        query: options
      )
    end

    ###
    # @param [Hash] options
    ###
    def self.destroy(options)
      id = id_param(options)

      delete(
        path: "/gears/#{id}",
        query: options
      )
    end
  end
end
