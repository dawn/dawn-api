require 'dawn/api/base_api'

module Dawn
  class Release
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
    data_key :image, write: false
    # @type [String]
    data_key :app_id, path: "app/id", write: false

    def app
      @app ||= App.find(id: app_id)
    end

    def refresh
      @data = request(
        expects: 200,
        method: :get,
        path: "/releases/#{id}",
        query: options
      )["release"]
    end

    def self.all(options={})
      get(
        path: "/releases",
        query: options
      ).map { |hsh| new hsh["release"] }
    end

    def self.find(options={})
      id = id_param(options)

      new get(
        path: "/releases/#{id}",
        query: options
      )["release"]
    end
  end
end
