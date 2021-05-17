# CiscoWebexApi

CiscoWebex::Api is a simple wrapper around the WebEx api.

[![Rubocop](https://github.com/lessonly/cisco_webex_api/actions/workflows/rubocop.yml/badge.svg)](https://github.com/lessonly/cisco_webex_api/actions/workflows/rubocop.yml)
[![RSpec](https://github.com/lessonly/cisco_webex_api/actions/workflows/rspec.yml/badge.svg)](https://github.com/lessonly/cisco_webex_api/actions/workflows/rspec.yml)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cisco_webex_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cisco_webex_api

## Usage

You can interact with the Cisco WebEx api using the built-in client class.

``` ruby
CiscoWebex::Api::Client.new(access_token: "xxxxx")
```

The client has access to api specific endpoints through delegated method calls.

``` ruby
client = CiscoWebex::Api::Client.new(access_token: "xxxxx")
client.meetings.create(...)
```

You may also directly interact with the api directly using the underlying class.

``` ruby
meeting = CiscoWebex::Api::Meeting.new(access_token: "xxxxx")
meeting.create(...)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cisco_webex_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/cisco_webex_api/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the CiscoWebexApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cisco_webex_api/blob/master/CODE_OF_CONDUCT.md).
