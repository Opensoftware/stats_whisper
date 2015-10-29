require 'spec_helper'
require 'stats_whisper/environment'

describe StatsWhisper::Environment do
  let(:ctxt) { Class.new { extend StatsWhisper::Environment } }


  describe "#backend" do

    %w(production staging test).each do |env|
      context "when environment is #{env}" do
        before do
          allow(ctxt).to receive(:environment).and_return(env)
          # allow(StatsWhisper::Backend::StatsD).to receive(:new).and_return("OK")
        end

        it 'returns statsd backend' do
          # expect(ctxt.backend).to eq("OK")
          expect(ctxt.backend).to be_kind_of(StatsWhisper::Backend::StatsD)
        end
      end
    end

    context "when environment is some_cool_env" do
      before do
        allow(ctxt).to receive(:environment).and_return('some_cool_env')
      end

      it 'returns logger backend' do
        expect(ctxt.backend).to be_kind_of(StatsWhisper::Backend::Logger)
      end
    end
  end

  describe "#app_name" do
    context "when env variable is defined" do
      it "returns env variable value" do
        allow(ENV).to receive(:[]).with("STATSWHISPER_APP").and_return("bar")
        expect(ctxt.app_name).to eq('bar')
      end
    end

    context "when env variable is undefined" do
      it "returns default value" do
        expect(ctxt.app_name).to eq('foo')
      end
    end
  end

  describe "#environment" do

    context 'when Rails defined' do
      before do
        Rails = double(:env => 'test')
      end

      after do
        Object.send(:remove_const, :Rails)
      end

      it "reads env from Rails" do
        expect(ctxt.environment).to eq('test')
      end
    end

    context 'when Rails undefined' do

      it "reads env from ENV" do
        allow(ENV).to receive(:[]).with("RAILS_ENV").and_return("test")
        expect(ctxt.environment).to eq('test')
      end

      it "sets development if ENV is empty" do
        expect(ctxt.environment).to eq('development')
      end
    end
  end
end
