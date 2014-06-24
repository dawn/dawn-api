require 'dawn/api/base_api'
require 'dawn/api/models/release'

module Dawn
  class App
    class Releases

      include BaseApi
      include Enumerable

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def to_a
        all
      end

      def each(&block)
        all.each(&block)
      end

      def create(options={})
        #options.fetch(:release)

        Release.new(post(
          path: "/apps/#{app.id}/releases",
          body: options.to_json
        )["release"]).tap { |d| d.app = @app }
      end

      def all(options={})
        get(
          path: "/apps/#{app.id}/releases",
          query: options
        ).map { |hsh| Release.new(hsh["release"]).tap { |d| d.app = @app } }
      end

      def find(options={})
        Release.find(options).tap { |d| d.app = @app }
      end

    end
  end
end
