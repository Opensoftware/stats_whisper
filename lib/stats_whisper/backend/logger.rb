module StatsWhisper::Backend

  class Logger

    attr_accessor :logger

    def initialize
      @logger = StatsWhisper.logger
    end

    def timing(path, timestamp)
      collect_metric("#{path}:#{timestamp}")
    end

    def collect_metric(metric)
      StatsWhisper.logger.info "[StatsWhisper] #{metric}"
    end

    alias_method :increment, :collect_metric
  end
end
