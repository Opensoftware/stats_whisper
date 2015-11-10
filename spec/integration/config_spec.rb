require 'spec_helper'
require 'stats_whisper/config'

describe StatsWhisper::Config do
  subject { Class.new { extend StatsWhisper::Config } }

  before do
    Rails = double(:root => Pathname.new("spec/fixtures"))
  end

  after do
    Object.send(:remove_const, :Rails)
  end

  describe "#app_name" do

    context "when config file is given" do
      it "returns specified app name" do
        expect(subject.app_name).to eq('bar')
      end
    end
  end
end
