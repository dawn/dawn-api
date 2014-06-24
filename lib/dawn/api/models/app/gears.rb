require 'dawn/api/base_api'
require 'dawn/api/models/gear'

module Dawn #:nodoc:
  class App #:nodoc:
    class Gears #:nodoc:
      include BaseApi, Enumerable

      # @type [Dawn::App]
      attr_reader :app

      ###
      # @param [Dawn::App] app
      ###
      def initialize(app)
        @app = app
      end

      ###
      # @return [Array<Dawn::Gear>]
      ###
      def to_a
        all
      end

      ###
      # @overload each { |gear| do_stuff_with_gear }
      ###
      def each(&block)
        all.each(&block)
      end

      ###
      # @return [Dawn::Gear]
      ###
      def create(options={})
        #options.fetch(:gear)

        Gear.new(post(
          path: "/apps/#{app.id}/gears",
          body: options.to_json
        )["gear"]).tap { |d| d.app = @app }
      end

      ###
      # @return [Array<Dawn::Gear>]
      ###
      def all(options={})
        get(
          path: "/apps/#{app.id}/gears",
          query: options
        ).map { |hsh| Gear.new(hsh["gear"]).tap { |d| d.app = @app } }
      end

      ###
      # @return [Dawn::Gear]
      ###
      def find(options={})
        Gear.find(options).tap { |d| d.app = @app }
      end

      def restart(options={})
        post(
          path: "/apps/#{app.id}/gears/restart",
          body: options.to_json
        )
      end

      def destroy(options)
        Gear.destroy(options)
      end
    end
  end
end
