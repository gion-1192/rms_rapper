require 'faraday'
require 'base64'

module RmsRapper
  class Client
    attr_accessor :service_secret, :license_key

    def initialize
      raise 'Error not calling in block' unless block_given?
      yield self
    end

    def rms_get(klass, params = {}, target = caller[0][/`([^']*)'/, 1])
      res = connection(klass::ENDPOINT).get do |req|
        req.url(target, params)
        req.headers['Authorization'] = auth_key
      end

      raise 'Failed to get connect to rms' unless res.success?
      res.body
    end

    def rms_post(klass, xml, target = caller[0][/`([^']*)'/, 1])
      res = connection(klass::ENDPOINT).post do |req|
        req.url(target)
        req.headers['Authorization'] = auth_key
        req.body = xml
      end

      raise 'Failed to post connect to rms' unless res.success?
      res.body
    end

    private

    def auth_key
      raise 'Error api undefined' if service_secret.nil? || license_key.nil?
      'ESA ' + Base64.strict_encode64(service_secret + ':' + license_key)
    end

    def connection(endpoint)
      Faraday.new(url: endpoint)
    end
  end

  def configration(&block)
    @client ||= Client.new(&block)
  end

  module_function :configration
end
