require "stats_whisper/middleware"

module StatsWhisper
  class Railtie < Rails::Railtie

    initializer 'statsd-instrument.use_rails_logger' do
      ::StatsWhisper.logger = Rails.logger
    end

    initializer "stats_whisper.insert_middleware" do |app|
      app.config.middleware.use "StatsWhisper::Middleware"
    end
  end
end
