module AMTD
  module Parsers

    class PriceHistoryDatapoint < ::BinData::Record
      float_be    :close   # may have to round this on a 64 bit system
      float_be    :high    # may have to round this on a 64 bit system
      float_be    :low     # may have to round this on a 64 bit system
      float_be    :open    # may have to round this on a 64 bit system
      float_be    :volume  # in 100s
      int64be     :timestamp # number of milliseconds - needs to be converted to seconds for Ruby
    end

  end
end
