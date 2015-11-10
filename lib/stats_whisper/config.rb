require 'yaml'

module StatsWhisper
  module Config

    def config
      @config ||= load_config
    end

    def whitelist
      config['whitelist'] || []
    end

    def app_name
      config['app_name'] || 'foo'
    end

    private

    def load_config
      begin
        YAML.load(ERB.new(File.new(Rails.root.join("config", "whisper_config.yml")).read).result)
      rescue Errno::ENOENT
        {}
      end
    end

  end
end
