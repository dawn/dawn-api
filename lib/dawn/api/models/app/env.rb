require 'dawn/api/base_api'

module Dawn #:nodoc:
  class App #:nodoc:
    class Env < Hash #:nodoc:
      # horrible hack to restore Hash#delete
      alias :__delete__ :delete
      include BaseApi
      alias :api_delete :delete
      alias :delete :__delete__
      remove_method :__delete__

      # @type [Dawn::App]
      attr_reader :app

      ###
      # @param [Dawn::App] app
      # @param [Hash] data
      ###
      def initialize(app, data)
        @app = app
        super()
        replace(data)
      end

      ###
      # @param [Hash] options
      ###
      def refresh(options={})
        replace get(
          path: "/apps/#{app.id}/env",
          query: options
        )["env"]
      end

      ###
      # @param [Hash] options
      ###
      def save(options={})
        replace post(
          path: "/apps/#{app.id}/env",
          body: { app: { env: merge(options) } }.to_json
        )["env"]
      end
    end
  end
end
