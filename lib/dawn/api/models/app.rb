require 'dawn/api/hosts'
require 'dawn/api/base_api'
require 'dawn/api/models/app/env'
require 'dawn/api/models/app/gears'
require 'dawn/api/models/app/drains'
require 'dawn/api/models/app/domains'
require 'dawn/api/models/app/releases'

module Dawn #:nodoc:
  class App #:nodoc:
    include BaseApi

    # @type [Dawn::App::Env]
    attr_reader :env
    # @type [String]
    data_key :id, write: false
    # @type [Integer]
    data_key :created_at, write: false
    # @type [Integer]
    data_key :updated_at, write: false
    # @type [String]
    data_key :name, write: false
    # @type [Hash<String, Integer>]
    data_key :formation

    ###
    # @param [Hash] data
    ###
    def initialize(data)
      @data = data
      @data["env"] = @env = Env.new(self, @data.delete("env"))
    end

    ###
    # Returns the git remote path for this App
    # @return [String]
    ###
    def git
      @git ||= "#{Dawn::Account.current.username}~#{name}.git"
    end

    ###
    # @return [Dawn::App::Gears]
    ###
    def gears
      @gears ||= Gears.new self
    end

    ###
    # @return [Dawn::App::Drains]
    ###
    def drains
      @drains ||= Drains.new self
    end

    ###
    # @return [Dawn::App::Domains]
    ###
    def domains
      @domains ||= Domains.new self
    end

    ###
    # @return [Dawn::App::Releases]
    ###
    def releases
      @releases ||= Releases.new self
    end

    ###
    # @return [self]
    ###
    def refresh(options={})
      @data = get(
        path: "/apps/#{id}",
        query: options
      )["app"]
      self
    end

    ###
    # @return [self]
    ###
    def update(options={})
      options.fetch(:app)

      @data = patch(
        path: "/apps/#{id}",
        body: options.to_json
      )["app"]
      self
    end

    ###
    # @return [self]
    ###
    def save
      update(app: @data)
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
    def run(options={})
      self.class.run(options.merge(id: id))
    end

    ###
    # @param [Hash] options
    ###
    def logs(options={})
      self.class.logs(options.merge(id: id))
    end

    ###
    # @param [Hash] options
    ###
    def scale(options={})
      @data["formation"] = self.class.scale(options.merge(id: id))
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
    def self.id_param(options)
      options.delete(:id) ||
      options.delete(:name) ||
      raise
    end

    ###
    # @param [Hash] options
    ###
    def self.create(options)
      options.fetch(:app)

      new post(
        path: "/apps",
        body: options.to_json
      )["app"]
    end

    ###
    # @param [Hash] options
    # @return [Array<Dawn::App>]
    ###
    def self.all(options={})
      get(
        path: "/apps",
        query: options
      ).map { |d| new d["app"] }
    end

    ###
    # @param [Hash] options
    ###
    def self.find(options)
      id = id_param(options)

      new get(
        path: "/apps/#{id}",
        query: options
      )["app"]
    end

    ###
    # @param [Hash] options
    ###
    def self.update(options)
      id = id_param(options)
      options.fetch(:app)

      new patch(
        path: "/apps/#{id}",
        body: options.to_json
      )["app"]
    end

    ###
    # @param [Hash] options
    ###
    def self.destroy(options={})
      id = id_param(options)

      delete(
        path: "/apps/#{id}",
        query: options
      )
    end

    ###
    # @param [Hash] options
    ###
    def self.restart(options={})
      id = id_param(options)

      post(
        path: "/apps/#{id}/gears/restart",
        body: options.to_json
      )
    end

    ###
    # @param [Hash] options
    ###
    def self.logs(options={})
      id = id_param(options)

      url = get(
        path: "/apps/#{id}/logs",
        query: options
      )["logs"]

      "http://#{Dawn.log_host}#{url}"
    end

    ###
    # @param [Hash] options
    ###
    def self.scale(options={})
      id = id_param(options)
      options.fetch(:app).fetch(:formation)

      post(
        path: "/apps/#{id}/scale",
        body: options.to_json
      )
    end

    ###
    # @param [Hash] options
    ###
    def self.run(options={})
      id = id_param(options)
      options.fetch(:command)

      post(
        path: "/apps/#{id}/run",
        body: options.to_json
      )
    end
  end
end
