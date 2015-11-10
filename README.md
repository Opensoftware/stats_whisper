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

Or install it yourself as:

    $ gem install stats_whisper

## Configuration

This library comes with Rails initializer and is ready to use once added to Gemfile app stack. It distinguishes Rails environments and for development environment Rails logger is used. All remaining use StatsD and it is possible to define StatsD location with these environment variables:

* `STATSWHISPER_HOST` – contains hostname where StatsD is listening;
* `STATSWHISPER_PORT` – contains StatsD port .

You can use here [dotenv][4] gem.


### Request paths filtering

By default StatsWhisper listens for any request path and allows all of them to pass. It causes that all request paths are passed to Graphite, which may not be expected bahaviour, because one would be interested only in certain paths, hence it is possible to provide a whitelist to filter "garbage".

Whitelist is an array of regexp patterns provided in config file:
```
# Rails.root/config/whisper_config.yml

---
whitelist:
  - ^/dashboard
  - /(pl|en)/main
```

Then, these patterns are matched against current request path. If path matches, it is passed to StatsD. The whitelist applies only to timers so all requests are counted, even though they don't match.

### Adding app name

To add app name to the metric path, add `app_name` to config file, e.g:

```
# Rails.root/config/whisper_config.yml

---
app_name: cool_app
```


## TODO

* Add configurable parser rules, letting the user to define patterns to translate request paths into [Graphite][3] format.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/stats_whisper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[1]: https://github.com/etsy/statsd/blob/master/docs/metric_types.md#timing
[2]: https://github.com/etsy/statsd/blob/master/docs/metric_types.md#counting
[3]: http://graphite.readthedocs.org/en/latest/overview.html
[4]: https://github.com/bkeepers/dotenv
