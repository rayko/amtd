module AMTD
  module Parsers

    class PriceHistory
      attr_reader :data, :terminator

      def initialize data
        raise ArgumentError, "Expected StringIO or File object. Got #{data.class}" unless data.is_a?(StringIO) || data.is_a?(File)
        @data = data
        @terminator = "\xFF\xFF"
      end

      def parse
        header = PriceHistoryHeader.read(data)
        return normalize_header(header) if header.error_code != 0

        datapoints = []
        while data.read(2).bytes != terminator.bytes
          data.seek(-2, IO::SEEK_CUR)
          datapoint = PriceHistoryDatapoint.read(data)
          datapoints << datapoint
        end
        data.rewind

        return normalize(header, datapoints)
      end

      private
      def normalize header, datapoints
        output = normalize_header(header)
        output[:data] = datapoints.map{|point| normalize_datapoint(point)}
        return output
      end

      def normalize_header header
        {
          :symbol_count => header.symbol_count,
          :symbol => header.symbol,
          :error_code => header.error_code,
          :error_text => header.error_text,
          :bar_count => header.bar_count
        }
      end

      def normalize_datapoint datapoint
        {
          :close => datapoint.close,
          :high => datapoint.high,
          :low => datapoint.low,
          :open => datapoint.open,
          :volume => datapoint.volume,
          :date => Time.at(datapoint.timestamp / 1000)
        }
      end
    end

  end
end
