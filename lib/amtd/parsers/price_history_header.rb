module AMTD
  module Parsers

    class PriceHistoryHeader < ::BinData::Record
      int32be    :symbol_count
      int16be    :symbol_length
      string     :symbol, :read_length => :symbol_length
      int8be     :error_code
      int16be    :error_length, :onlyif => :has_error?
      string     :error_text, :onlyif => :has_error?, :length=>:error_length
      int32be    :bar_count

      def has_error?
        error_code != 0
      end
    end
    
  end
end
