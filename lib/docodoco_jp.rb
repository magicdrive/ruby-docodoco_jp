# coding: utf-8

require "docodoco_jp/version"
require "docodoco_jp/ipv4_validation_error"
require "docodoco_jp/api_key_invalid"

require "faraday"
require "hashie"
require "resolv"

require "json"
require 'rexml/document'

class DocodocoJp

  API_HOST = 'api.docodoco.jp'

  attr_reader :apikey
  attr_reader :config
  attr_reader :user_valid

  class << self
    def default_config
      return {
        ssl: true,
        faraday_log: false,
        charset: "utf_8",
        response_type: :hashie
      }
    end
  end

  def initialize(apikey1, apikey2, options ={})
    @apikey = [apikey1, apikey2]
    @user_valid = false
    @config = self.class.default_config
    @config = @config.merge({
      ssl: options[:ssl],
      faraday_log: options[:faraday_log],
      charset: options[:charset],
      response_type: options[:response_type]
    }) do |k, n, o|
      result = n
      result = o unless o.nil?

      result
    end
  end

  def search(ipadr = nil)
    result = hash_nomalize(JSON.parse(search_api(ipadr).body))
    if config[:response_type] == :hashie
      result = Hashie::Mash.new(result)
    end
    return result
  end

  def check_user()
    xmldoc = REXML::Document.new(check_user_api().body)
    status  = xmldoc.elements['/docodoco/user_status'].get_text.to_s.to_i
    message = xmldoc.elements['/docodoco/user_status_message'].get_text.to_s
    result = [200, 201].include?(status)
    @user_valid = true
    return result, {status: status, message: message}
  end

  def check_user!()
    result, json = check_user
    raise DocodocoJp::ApiKeyInvalid unless result
    return result, json
  end

  private
  def check_user_api()
    return api_request "/v4/user_info", api_params
  end

  def search_api(ipadr = nil)
    raise DocodocoJp::IPv4ValidationError unless ipadr.nil? || Resolv::IPv4::Regex =~ ipadr
    return api_request "/v4/search", api_params(format: :json, charset: config[:charset], ipadr: ipadr)
  end

  def api_params(h = {})
    return {
      key1: @apikey[0],
      key2: @apikey[1],
    }.merge(h)
  end

  def connection
    return @connection ||= ->() {
      protocol = config[:ssl] ? "https:" : "http"
      options  = config[:ssl] ? { ssl: { verify: true } } : {}
      Faraday.new("#{protocol}//#{API_HOST}", options) do |builder|
        builder.request  :url_encoded
        builder.response :logger if config[:debug]
        builder.adapter  :net_http
      end
    }.call()
  end

  def api_request(path, params)
    response = connection.get path, params
    return response
  end

  def hash_nomalize(obj)
    snakecase = ->(str) do
      return str.downcase if str =~ /^[A-Z]+$/xom
      return str.scan(/[A-Z][a-z]*/xom).join("_").downcase
    end
    return obj.inject({}){|memo,(k,v)| memo[snakecase.(k.to_s).intern] = hash_nomalize(v); memo} if obj.is_a? Hash
    return obj.inject([]){|memo,v| memo << hash_nomalize(v); memo} if obj.is_a? Array
    return obj
  end

end

__END__

