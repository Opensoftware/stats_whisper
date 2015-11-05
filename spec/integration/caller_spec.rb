require 'spec_helper'
require 'stats_whisper/caller'

describe StatsWhisper::Caller do
  subject { Class.new { extend StatsWhisper::Caller } }

  describe "#gather_stats" do

    before do
      Rails = double(:root => Pathname.new("spec/fixtures"))
    end

    after do
      Object.send(:remove_const, :Rails)
    end

    context "when whitelist is given" do
      it "allows only certain paths" do
        expect(subject.timing_allowed?("/en/main")).to eq(true)
      end
    end
  end
end
