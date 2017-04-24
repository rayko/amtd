require 'spec_helper'

describe AMTD::Configuration do
  describe '#new' do
    it 'has the default values' do
      config = AMTD::Configuration.new

      expect(config.source).to eq(nil)
      expect(config.version).to eq(nil)
      expect(config.host).to eq(nil)
      expect(config.path).to eq(nil)
    end
  end

end
