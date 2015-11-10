require 'spec_helper'
require 'stats_whisper/config'

describe StatsWhisper::Config do
  let(:ctxt) { Class.new { extend StatsWhisper::Config } }

  describe "#whitelist" do

    context "when whitelist in config is empty" do
      before do
        allow(ctxt).to receive(:config).and_return({})
      end

      it "returns an empty array" do
        expect(ctxt.whitelist).to eq([])
      end
    end

    context "when whitelist in config is not empty" do
      before do
        allow(ctxt).to receive(:config).and_return({'whitelist' => ['ok!']})
      end

      it "returns non-empty array" do
        expect(ctxt.whitelist).not_to be_empty
      end
    end
  end

  describe "#app_name" do
    context "when app_name in config is empty" do
      before do
        allow(ctxt).to receive(:config).and_return({})
      end

      it "returns default value" do
        expect(ctxt.app_name).to eq('foo')

      end
    end

    context "when env variable is undefined" do
      before do
        allow(ctxt).to receive(:config).and_return({'app_name' => "cool_app"})
      end

      it "returns provided app name" do
        expect(ctxt.app_name).to eq('cool_app')
      end
    end
  end

  describe "#config" do
    before do
      Rails = double(:root => Pathname.new(fixtures_path))
    end

    after do
      Object.send(:remove_const, :Rails)
    end

    context "when config file is not present" do
      let(:fixtures_path) { "spec/non_existing_fixtures" }


      it "returns empty hash" do
        expect(ctxt.config).to eq({})
      end
    end

    context "when config file is present" do
      let(:fixtures_path) { "spec/fixtures" }


      it "returns non empty hash" do
        expect(ctxt.config).not_to be_empty
      end
    end
  end
end
