require 'dawn/api/version'
require 'excon'
require 'netrc'

module Dawn

  HEADERS = {
    'Accept'                => 'application/json',
    'Content-Type'          => 'application/json',
    'Accept-Encoding'       => 'gzip',
    'User-Agent'            => "dawn/#{API::VERSION}",
    'X-Ruby-Version'        => RUBY_VERSION,
    'X-Ruby-Platform'       => RUBY_PLATFORM
  }

  OPTIONS = {
    headers:  {},
    nonblock: false,
  }

  class AuthenticationError < RuntimeError
  end

  class << self
    attr_accessor :last_response_body
  end

  def self.request(options)
    Dawn.authenticate unless @connection
    expects = options.delete(:expects)
    response = @connection.request(options)
    self.last_response_body = response.body
    if expects && response.status != expects
      raise Excon::Errors.status_error(options.merge(expects: expects), response)
    end
    response
  end

  def self.authenticate(options={})
    options = OPTIONS.merge(host: dawn_api_host, scheme: dawn_scheme).merge(options)
    options[:headers] = options[:headers].merge(HEADERS)
    @api_key = options.delete(:api_key) || ENV['DAWN_API_KEY']

    if !@api_key
      hostname = options[:host]
      url = "#{options[:scheme]}://#{hostname}"

      if options.key?(:username) && options.key?(:password)
        username = options.delete(:username)
        password = options.delete(:password)

        @connection = Excon.new url, headers: HEADERS

        @api_key = User.login(username: username, password: password)['api_key']

        netrc = Netrc.read
        netrc[hostname] = username, @api_key
        netrc.save
      else
        netrc = Netrc.read
        username, api_key = netrc[hostname]
        if api_key
          @api_key = api_key
        else
          raise AuthenticationError, "api_key was not found, try dawn login to reset your .netrc"
          # "please provide a DAWN_API_KEY, username and password, or update your .netrc with the dawn details (use dawn login)"
        end
      end
    end
    @headers = HEADERS.merge 'Authorization' => "Token token=\"#{@api_key}\""
    @connection = Excon.new "#{options[:scheme]}://#{options[:host]}", headers: @headers
  end

end
