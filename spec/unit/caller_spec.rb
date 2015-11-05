require 'spec_helper'
require 'stats_whisper/caller'

describe StatsWhisper::Caller do
  let(:ctxt) { Class.new { extend StatsWhisper::Caller } }

  describe "#timing_allowed?" do

    context "when whitelist is empty" do
      it "allows to receive any path" do
        allow(ctxt).to receive(:whitelist).and_return([])
        expect(ctxt.timing_allowed?("/bleh/blah/ok")).to eq(true)
      end
    end

    context "when whitelist is not empty" do
      before do
        allow(ctxt).to receive(:whitelist).and_return(["/home.*"])
      end

      it "allows only certain paths" do
        expect(ctxt.timing_allowed?("/home/page")).to eq(true)
      end

      it "rejects not allowed paths" do
        expect(ctxt.timing_allowed?("/dashboard")).to eq(false)
      end
    end

  end
end
