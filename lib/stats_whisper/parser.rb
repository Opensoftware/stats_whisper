module StatsWhisper::Parser

  def parse(path)
    path = path.gsub(/\/(pl|en|(\d){4}\-(\d){4})/) do
      if $'.empty?
        '/'
      end
    end
    path.slice!(0) if path =~ /\/.+/
    path.sub(/^\/$/, "home_page").gsub('/', '.')
  end

  def build_key(*args)
    args.join(".")
  end

end
