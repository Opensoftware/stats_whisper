require_relative "environment"
require_relative "parser"
require_relative "config"

module StatsWhisper

  module Caller

    include Parser
    include Config

    def gather_stats(env, response_time)

      if timing_allowed?(env["REQUEST_PATH"])
        req_path = parse(env["REQUEST_PATH"])
        StatsWhisper.backend.timing(build_key(app_name, 'http', env["REQUEST_METHOD"],
                                              req_path,
                                              'response_time'),
                                    response_time)
        StatsWhisper.backend.increment(build_key(app_name, 'http', req_path, 'visits'))
      end
      StatsWhisper.backend.increment(build_key(app_name, 'http', 'visits'))
    end

    def timing_allowed?(request_path)
      whitelist.empty? || whitelist.any? do |pattern|
        Regexp.new(pattern) =~ request_path
      end

    end

  end
end
