## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gerrithooks_autorebase_changemerged'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gerrithooks_autorebase_changemerged

## Usage

Set the following environment variables:

    AUTOREBASE_PROJECTS="comma,separated,projects"
    GERRITHOOK_USER="user-with-rest-api-access"
    GERRITHOOK_PASSWORD="password"

## Development

To build go to project root and run:
    $ rake build_gems

To run specs, go to project root and run
    $ rake spec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gerrithooks_autorebase_changemerged.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
