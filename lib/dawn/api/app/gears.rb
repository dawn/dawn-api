require 'dawn/api/base_api'
require 'dawn/api/gear'

module Dawn
  class App
    class Gears

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def each(&block)
        all.each(&block)
      end

      def create(options={})
        options.fetch(:gear)

        Gear.new(post(
          path: "/apps/#{app.id}/gears",
          body: options.to_json
        )["gear"]).tap { |d| d.app = @app }
      end

      def all(options={})
        get(
          path: "/apps/#{app.id}/gears",
          query: options
        ).map { |hsh| Gear.new(hsh["gear"]).tap { |d| d.app = @app } }
      end

      def find(options={})
        Gear.find(options).tap { |d| d.app = @app }
      end

      def restart(options={})
        post(
          path: "/apps/#{app.id}/gears/restart",
          body: options.to_json
        )
      end

    end
  end
end
