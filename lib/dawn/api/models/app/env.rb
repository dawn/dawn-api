require 'dawn/api/base_api'

module Dawn
  class App
    class Env < Hash

      alias :__delete__ :delete
      include BaseApi
      alias :api_delete :delete
      alias :delete :__delete__
      remove_method :__delete__

      attr_reader :app

      def initialize(app, data)
        @app = app
        super()
        replace(data)
      end

      def refresh(options={})
        replace get(
          path: "/apps/#{app.id}/env",
          query: options
        )["env"]
      end

      def save(options={})
        replace post(
          path: "/apps/#{app.id}/env",
          body: { app: { env: merge(options) } }.to_json
        )["env"]
      end

    end
  end
end
