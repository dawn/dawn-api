require 'dawn/api/base_api'

module Dawn
  class Gear
    include BaseApi

    attr_reader :data
    attr_writer :app

    def initialize(data)
      @app = nil
      @data = data
    end

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

    def app
      @app ||= App.find(id: app_id)
    end

    def refresh
      @data = get(
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

    def restart(options={})
      self.class.restart(options.merge(id: id))
    end

    def destroy(options)
      self.class.destroy(options.merge(id: id))
    end

    def self.all(options={})
      get(
        path: "/gears",
        query: options
      ).map { |d| new d["gear"] }
    end

    def self.find(options)
      id = id_param(options)

      new get(
        path: "/gears/#{id}",
        query: options
      )["gear"]
    end

    def self.restart(options={})
      self.class.restart(options.merge(id: id))

      post(
        path: "/gears/#{id}/restart",
        query: options
      )
    end

    def self.destroy(options)
      id = id_param(options)

      delete(
        path: "/gears/#{id}",
        query: options
      )
    end
  end
end
