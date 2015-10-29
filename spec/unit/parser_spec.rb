require 'spec_helper'
require 'stats_whisper/parser'

describe StatsWhisper::Parser do
  let(:ctxt) { Class.new { extend StatsWhisper::Parser } }

  describe "#parse" do


    context "when req path is empty" do
      it "resolves base uri" do
        path = "/"
        expect(ctxt.parse(path)).to eq("home_page")
      end
    end

    context "when req path is root path" do
      it "resolves root path" do
        path = "/en"
        expect(ctxt.parse(path)).to eq("home_page")
      end
    end

    context "when req path points to a resource" do
      it "resolves resource path" do
        path = "/en/dashboard"
        expect(ctxt.parse(path)).to eq("dashboard")

        path = "/2015-2016/pl/treasuries/academy_units/offer"
        expect(ctxt.parse(path)).to eq("treasuries.academy_units.offer")
      end
    end
  end

  describe "#build_key" do
    it "generates valid Graphite key" do
      expect(ctxt.build_key("bleh", 'blah', "dash")).to eq("bleh.blah.dash")
    end
  end
end
