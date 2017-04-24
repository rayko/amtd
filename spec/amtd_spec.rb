require 'spec_helper'

describe AMTD do
  describe ".configure" do
    it 'configures the gem' do
      expect(Proc.new{AMTD.configure{|c| c.source = 'source'}}).not_to raise_error
    end
  end

  describe '.configuration' do
    it 'returns a configuration object' do
      expect(AMTD.configuration.class).to eq(AMTD::Configuration)
    end
  end

  describe '.config' do
    it 'returns a configuration object' do
      expect(AMTD.config.class).to eq(AMTD::Configuration)
    end

    it 'it returns the same object as .configuration' do
      expect(AMTD.config).to eq(AMTD.configuration)
    end
  end
end
