require_relative 'config'

require_relative 'backend/logger'
require_relative 'backend/statsd'


module StatsWhisper
  module Environment

    include Config

    def backend
      case environment
      when 'production', 'staging', 'test'
        Backend::StatsD.new
      else
        Backend::Logger.new
      end
    end

    def environment
      if defined?(Rails)
        Rails.env
      else
        ENV['RAILS_ENV'] || 'development'
      end
    end

  end
end
