module Dawn

  def self.dawn_scheme
    ENV["DAWN_SCHEME"] || "http"
  end

  def self.dawn_host
    ENV["DAWN_HOST"] || "dawn.dev"
  end

  def self.dawn_api_host
    ENV["DAWN_API_HOST"] || "api.#{dawn_host}"
  end

  def self.git_host
    ENV["DAWN_GIT_HOST"] || dawn_host
  end

  def self.log_host
    ENV["DAWN_LOG_HOST"] || "#{dawn_host}:8001"
  end

end
