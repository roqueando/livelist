# Livelist

A Livelist manipulating gem for .m3u8 files!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'livelist'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install livelist

## Usage

You can use Livelist separately with `Livelist::Playlist`, `Livelist::Segment` and `Livelist::Sequence`

TODO: put an example

Or use a specific module to HLS: `Livelist::HLS`

```ruby
require 'livelist'

# That path index.m3u8 is where that
# file will be created
Livelist::HLS::Pipeline
    .new('path/to/index.m3u8')
    .run('segment.ts')
```

The logic is to work as a production pipeline, passing where will stay the final .m3u8 and which file will be faceted.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/roqueando/livelist

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
