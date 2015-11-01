# StatsWhisper

Short and simple piece of code to deal with stats gathering. It integrates Rails apps with StatsD and measures two fundamental values:

* Time of request execution (in ms) – each request is distinguished by its path, e.g: `/foo/bar` and `/bar/baz` are considered differently. It uses StatsD [time][1] metric type.
* Count of visits – a natural number of processed requests for the whole app. Basically it uses StatsD [counter][2] type.

As StatsD is mainly a network daemon to aggregate and send metrics, some another tool is needed for further processing or visualization, e.g. [Graphite][3].

Request paths are translated into Graphite metric pattern, e.g: `/foo/bar` becomes `app_name.foo.bar`. Moreover, for some particular paths replace operation is being done:

* `/en/foo/bar` => `app_name.foo.bar`;
* `/en` => `app_name.home_page`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stats_whisper'
```

And then execute:

    $ bundle

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stats_whisper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stats_whisper

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/stats_whisper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
