require 'spec_helper'

describe AMTD::XMLParser do
  before do
    @data = File.read(fixture_path.join('login/example.xml'))
  end

  describe '.new' do
    it 'accepts xml string' do
      expect(Proc.new{AMTD::XMLParser.new(@data)})
    end

    it 'builds a Nokogiri object' do
      object = AMTD::XMLParser.new(@data)
      expect(object.document.class).to eq(Nokogiri::XML::Document)
    end

    it 'cleans up input text' do
      expected = @data.gsub("\n", "").gsub(/>\s+</, "><")
      object = AMTD::XMLParser.new(@data)
      expect(object.data).to eq(expected)
    end
  end

  describe "#to_h" do
    it 'converts to hash' do
      object = AMTD::XMLParser.new(@data).to_h
      expect(object.class).to eq(Hash)
      expect(object.empty?).to eq(false)
    end
  end
end
