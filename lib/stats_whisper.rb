require "stats_whisper/version"
require 'logger'


module StatsWhisper
  extend self

  attr_accessor :logger

end

StatsWhisper.logger = Logger.new($stderr)
