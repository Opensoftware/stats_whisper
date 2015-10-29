require 'statsd-ruby'

module StatsWhisper::Backend

  class StatsD

    extend Forwardable

    def_delegators :@statsd, :increment, :timing

    def initialize
      @statsd = Statsd.new(hostname, port)
    end

    def hostname
      ENV['STATSWHISPER_HOST'] || 'localhost'
    end

    def port
      ENV['STATSWHISPER_PORT'] || 8125
    end
  end
end
