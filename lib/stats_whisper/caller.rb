require_relative "environment"
require_relative "parser"

module StatsWhisper

  module Caller

    include Parser
    include Environment

    def gather_stats(env, response_time)

      unless env["REQUEST_PATH"] =~ /^\/assets.*/
        backend.timing(build_key(app_name, 'http', env["REQUEST_METHOD"],
                                 parse(env["REQUEST_PATH"]),
                                 'response_time'),
                       response_time)
        backend.increment(build_key(app_name, 'http', 'visits'))
      end
    end
  end
end
