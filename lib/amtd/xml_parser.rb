module AMTD
  class XMLParser
    attr_reader :data, :parsed
    
    def initialize data
      @data = clean_data(data)
    end

    def to_h
      @parsed ||= Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym }).parse(@data)
      @parsed[:amtd]
    end

    private
    def clean_data data
      cleaned = data.gsub("\n", "")
      cleaned.gsub(/>\s+</, "><")
    end

  end
end
