[![Gem Version](https://badge.fury.io/rb/docodoco_jp.svg)](http://badge.fury.io/rb/docodoco_jp)

# DocodocoJp

[www.docodoco.jp](http://www.docodoco.jp) api client library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'docodoco_jp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install docodoco_jp

## Usage

#### * command line

    Usage:
      docodoco_jp config --key1=KEY1 --key2=KEY2  # Setup the API key to cli use
      docodoco_jp config_check                    # Check configred API key
      docodoco_jp help [TASK]                     # Describe available tasks or one specific task
      docodoco_jp search [IP_ADDRESS]             # Search target IP_ADDRESS infomation
      docodoco_jp show_key                        # Show configred API key

#### * ruby script

```ruby
require 'docodoco_jp'

apikey1 = "YOUR_APIKEY_1"
apikey2 = "YOUR_APIKEY_2"

options = {
    ssl: false,              # => default: true
    faraday_log: true,       # => default: false
    charset: "euc_jp",       # => default: utf-8
    response_type: :json     # => default: hashie
  }

ipv4addr = "210.251.250.30"

docodoco_jp = DocodocoJp.new(apikey1, apikey2, options)
docodoco_jp.check_user # valid user, apikeys

result = docodoco_jp.search(ipv4addr)
```

### enjoy!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/magicdrive/docodoco_jp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

