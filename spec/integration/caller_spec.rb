require 'spec_helper'
require 'stats_whisper/caller'
require_relative 'statsd_helper'

describe StatsWhisper::Caller do
  subject { Class.new { extend StatsWhisper::Caller } }

  before do
    Rails = double(:root => Pathname.new("spec/fixtures"))
  end

  after do
    Object.send(:remove_const, :Rails)
  end

  describe "#gather_stats" do
    before do
      allow(Rails).to receive(:env).and_return("production")

      StatsWhisper.backend = StatsD.new

    end

    it "adds timing stats" do
      subject.gather_stats({'REQUEST_PATH' => '/en/main',
                            'REQUEST_METHOD' => 'GET'}, 234)
      expect(StatsWhisper.backend.timing_key).to eq('bar.http.GET.main.response_time')
      expect(StatsWhisper.backend.increment_key).to eq('bar.http.visits')

    end

  end

  describe "#timing_allowed?" do

    context "when whitelist is given" do
      it "allows only certain paths" do
        expect(subject.timing_allowed?("/en/main")).to eq(true)
      end
    end
  end
end
