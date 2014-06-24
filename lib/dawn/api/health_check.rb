module Dawn
  module API

    def self.health_check
      Dawn.request(
        expects: 200,
        method: :get,
        path: "/healthcheck"
      )
    end

  end
end
