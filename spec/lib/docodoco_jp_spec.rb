# encoding: utf-8

require File.expand_path("../spec_helper", File.dirname(__FILE__))
require 'minitest/autorun'
require 'docodoco_jp'
require 'yaml'

DocodocoJp::api_host = "localhost:9292"

describe DocodocoJp do
  before do
    test_yaml = YAML.load_file(File.expand_path("../../fixtures/test_apikey.yml", File.dirname(__FILE__)))
    @key1 = test_yaml["apikey1"]
    @key2 = test_yaml["apikey2"]
  end

  describe "configure" do
    it "default_config" do
      docodoco_jp = DocodocoJp.new(@key1, @key2)
      assert_equal DocodocoJp.default_config, docodoco_jp.config
    end
    it "custom_config" do
      options = {
        ssl: false,
        faraday_log: true,
        charset: "euc_jp",
        response_type: :json
      }
      docodoco_jp = DocodocoJp.new(@key1, @key2, options)
      assert_equal options, docodoco_jp.config
    end
  end

  describe "check_user_api" do
    it "normality" do
      docodoco_jp = DocodocoJp.new(@key1, @key2, {ssl: false})
      result, _ = docodoco_jp.check_user()
      assert_equal result, true
    end

    it "invalid user" do
      docodoco_jp = DocodocoJp.new("--fuga--", "--hoge--", {ssl: false})
      result, _ = docodoco_jp.check_user()
      assert_equal false, result
    end

    it "normality with error" do
      docodoco_jp = DocodocoJp.new(@key1, @key2, {ssl: false})
      result, _ = docodoco_jp.check_user!()
      assert_equal true, result
    end

    it "invalid user with error" do
      docodoco_jp = DocodocoJp.new("--fuga--", "--hoge--", {ssl: false})
      assert_raises(DocodocoJp::ApiKeyInvalid) {
        _, _ = docodoco_jp.check_user!()
      }
    end
  end

  describe "search_api" do
    it "normality" do
      docodoco_jp = DocodocoJp.new(@key1, @key2, {ssl: false})
      result = docodoco_jp.search()
      result.keys.each do |key|
        assert_equal true, SEARCH_API_RESPONSE_KEYS.include?(key)
      end
    end

    it "invalid ipaddr" do
      assert_raises(DocodocoJp::IPv4ValidationError) {
        docodoco_jp = DocodocoJp.new(@key1, @key2, {ssl: false})
        _ = docodoco_jp.search("hogehoge")
      }
    end
  end
end


__END__

