StatsD = Class.new do
  def timing(key, time); @timing = key; end
  def increment(key); @increment ||= Array.new; @increment.push key; end

  def timing_key; @timing; end
  def increment_key; @increment.pop; end
end
