require 'dawn/api/base_api'
require 'dawn/api/release'

module Dawn
  class App
    class Releases

      include BaseApi

      attr_reader :app

      def initialize(app)
        @app = app
      end

      def create(options={})
        Release.new(json_request(
          expects: 200,
          method: :post,
          path: "/apps/#{app.id}/releases",
          body: options.to_json
        )["release"]).tap { |d| d.app = @app }
      end

      def all(options={})
        json_request(
          expects: 200,
          method: :get,
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
