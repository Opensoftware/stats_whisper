StatsD = Class.new do
  def initalize(hostname, port); @increment = 0; end
  def timing(key, time); @timing = key; end
  def increment(key); @increment = key; end

  def timing_key; @timing; end
  def increment_key; @increment; end
end
