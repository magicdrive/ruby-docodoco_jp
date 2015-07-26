# coding: utf-8

require 'fileutils'
require 'thor'
require 'yaml'
require 'json'
require 'docodoco_jp'

class DocodocoJp
  class CLI < Thor
    desc "search [IP_ADDRESS]", "Search target IP_ADDRESS infomation."
    def search(ipaddr)
      $stdout.puts JSON.pretty_generate(client.search(ipaddr))
    end

    desc "config", "Setup the apikey to cli use"
    option :key1, required: true, type: :string
    option :key2, required: true, type: :string
    def config
      buf = {"apikey1" => options[:key1], "apikey2" => options[:key2]}.to_yaml
      FileUtils.mkdir_p(File.expand_path("~/.docodoco_jp/"))
      File.open(File.expand_path("~/.docodoco_jp/apikey.yml"), "w") { |f| f.print(buf) }
      $stdout.puts "config ok."
      self.invoke(:show_keys, [], {})
    end

    desc "show_key", "Show the apikey"
    def show_keys
      key1, key2 = get_apikeys()
      $stdout.puts JSON.pretty_generate({apikey1: key1, apikey2: key2})
    end

    desc "check_key", "Check apikey"
    def check
      result, json = client.check_user()
      $stdout.puts JSON.pretty_generate(json)
    end

    private
    def client
      return @instance ||= DocodocoJp.new(*get_apikeys())
    end

    def get_apikeys
      if File.exist?(File.expand_path("~/.docodoco_jp/apikey.yml"))
        docodoco_jp_conf = YAML.load_file(File.expand_path("~/.docodoco_jp/apikey.yml", File.dirname(__FILE__)))
        key1 = docodoco_jp_conf["apikey1"]
        key2 = docodoco_jp_conf["apikey2"]
        return key1, key2
      else
        print_setup_help
      end
    end

    def print_setup_help
      $stderr.puts <<-HELP
        docodoco.jp apikeys not found. please execute `docodocojp setup` or edit ~/.docodoco_jp/apikey.yml
      HELP
      exit 1
    end

  end
end

