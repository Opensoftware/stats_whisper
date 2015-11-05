require_relative "environment"
require_relative "parser"
require_relative "config"

module StatsWhisper

  module Caller

    include Parser
    include Environment
    include Config

    def gather_stats(env, response_time)

      if timing_allowed?(env["REQUEST_PATH"])
        backend.timing(build_key(app_name, 'http', env["REQUEST_METHOD"],
                                 parse(env["REQUEST_PATH"]),
                                 'response_time'),
                       response_time)
      end
      backend.increment(build_key(app_name, 'http', 'visits'))
    end

    def timing_allowed?(request_path)
      whitelist.empty? || whitelist.any? do |pattern|
        Regexp.new(pattern) =~ request_path
      end

    end

  end
end
