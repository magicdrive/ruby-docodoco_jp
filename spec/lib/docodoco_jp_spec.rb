# encoding: utf-8

require File.expand_path("../spec_helper", File.dirname(__FILE__))
require 'minitest/spec'
require 'minitest/autorun'
require 'docodoco_jp'
require 'yaml'

require 'search_api_response_keys'

describe DocodocoJp do
  before do
    test_yaml = YAML.load_file(File.expand_path("~/.docodoco_jp/apikey.yml", File.dirname(__FILE__)))
    @key1 = test_yaml["apikey1"]
    @key2 = test_yaml["apikey2"]
  end

  describe "configure" do
    it "default_config" do
      docodoco_jp = DocodocoJp.new(@key1, @key2)
      docodoco_jp.config.must_equal DocodocoJp.default_config
    end
    it "custom_config" do
      options = {
        ssl: false,
        faraday_log: true,
        charset: "euc_jp",
        response_type: :json
      }
      docodoco_jp = DocodocoJp.new(@key1, @key2, options)
      docodoco_jp.config.must_equal options
    end
  end

  describe "check_user_api" do
    it "normality" do
      docodoco_jp = DocodocoJp.new(@key1, @key2)
      result, json = docodoco_jp.check_user()
      result.must_equal true
    end

    it "invalid user" do
      docodoco_jp = DocodocoJp.new("--fuga--", "--hoge--")
      result, json = docodoco_jp.check_user()
      result.must_equal false
    end

    it "normality with error" do
      docodoco_jp = DocodocoJp.new(@key1, @key2)
      result, json = docodoco_jp.check_user!()
      result.must_equal true
    end

    it "invalid user with error" do
      docodoco_jp = DocodocoJp.new("--fuga--", "--hoge--")
      proc {
        result, json = docodoco_jp.check_user!()
      }.must_raise DocodocoJp::ApiKeyInvalid
    end
  end

  describe "search_api" do
    it "normality" do
      docodoco_jp = DocodocoJp.new(@key1, @key2)
      result = docodoco_jp.search()
      result.keys.must_equal SEARCH_API_RESPONSE_KEYS
    end

    it "invalid ipaddr" do
      proc {
        docodoco_jp = DocodocoJp.new(@key1, @key2)
        result = docodoco_jp.search("hogehoge")
      }.must_raise DocodocoJp::IPv4ValidationError
    end
  end
end


__END__

