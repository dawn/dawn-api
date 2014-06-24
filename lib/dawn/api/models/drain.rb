require 'dawn/api/base_api'

module Dawn
  class Drain
    include BaseApi

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

    def initialize(data)
      @app = nil
      @data = data
    end

    def app
      @app ||= App.find(id: app_id)
    end

    def refresh
      @data = get(
        path: "/drains/#{id}",
        query: options
      )["drain"]
    end

    def destroy(options={})
      Drain.destroy(options.merge(id: id))
    end

    def self.find(options={})
      id = id_param(options)

      new get(
        path: "/drains/#{id}",
        query: options
      )["drain"]
    end

    def self.destroy(options={})
      id = id_param(options)

      delete(
        path: "/drains/#{id}",
        query: options
      )
    end
  end
end
