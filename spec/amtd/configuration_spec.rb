require 'spec_helper'

describe AMTD::Configuration do
  describe '#new' do
    it 'has the default values' do
      config = AMTD::Configuration.new

      expect(Proc.new{config.source}).not_to raise_error
      expect(Proc.new{config.base_path}).not_to raise_error
    end
  end

end
