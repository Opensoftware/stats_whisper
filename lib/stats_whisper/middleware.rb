require_relative 'caller'

module StatsWhisper
  class Middleware

    include Caller

    def initialize(app)
      @app = app
    end

    def call(env)
      (status, headers, body), response_time = call_with_timing(env)
      gather_stats(env, response_time)
      [status, headers, body]
    end

    def call_with_timing(env)
      start = Time.now
      result = @app.call(env)
      [result, ((Time.now - start) * 1000).round]
    end
  end
end
