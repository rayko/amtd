module AMTD
  class XMLParser
    attr_reader :data, :document
    
    def initialize data
      @data = clean_data(data)
      @document = Nokogiri::XML(@data)
    end

    def to_h
      convert_to_hash({}, @document.children.first)
    end

    private
    def clean_data data
      cleaned = data.gsub("\n", "")
      cleaned.gsub(/>\s+</, "><")
    end

    def convert_to_hash result, element
      element.children.each do |child|
        if child.children.any? && !(child.children.size == 1 && child.children.first.class == Nokogiri::XML::Text)
          result[child.name] = convert_to_hash({}, child)
        else
          result[child.name] = child.content
        end
      end
      return result
    end
  end

end
