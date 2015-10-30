require "stats_whisper/version"
require 'logger'


require 'stats_whisper/railtie' if defined?(Rails)

module StatsWhisper
  extend self

  attr_accessor :logger

end

StatsWhisper.logger = Logger.new($stderr)
