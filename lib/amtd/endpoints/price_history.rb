# source=#{@source_id} requestidentifiertype=SYMBOL requestvalue=#{symbol} intervaltype=DAILY intervalduration=1 startdate=#{begin_date} enddate=#{end_date}

module AMTD
  module Endpoints

    class PriceHistory < BaseEndpoint
      PERIOD_TYPES = [:day, :month, :year, :ytd]
      PERIOD_VALUES = { :day => [1,2,3,4,5,10], :month => [1,2,3,6], :year => [1,2,3,5,10,15,20], :ytd => [1] }
      INTERVAL_TYPES = [:minute, :daily, :weekly, :montly]
      INTERVAL_DURATIONS = {:minute => [1,5,10,15,30], :daily => [1], :weekly => [1], :monthly => [1]}

      attr_reader :adapter, :response, :request_parameters

      def initialize adapter, params
        @adapter = adapter
        @request_parameters = validate_params!(params)
        @request_parameters.merge! default_parameters
        @session = @request_parameters.delete :session
        validate_endpoint_params!
      end
      
      def execute!
        result = @adapter.get :url => url, :headers => headers, :query => parse_params
        handle_response(result)
      end

      private
      def parse_params
        parsed = {}
        parsed[:source] = request_parameters[:source]
        parsed[:requestidentifiertype] = request_parameters[:request_identifier_type]
        parsed[:requestvalue] = request_parameters[:request_value]
        parsed[:intervaltype] = request_parameters[:interval_type].to_s.upcase
        parsed[:intervalduration] = request_parameters[:interval_duration]
        parsed[:periodtype] = request_parameters[:period_type].to_s.upcase if request_parameters[:period_type]
        parsed[:period] = request_parameters[:period] if request_parameters[:period]
        parsed[:startdate] = request_parameters[:start_date].strftime("%Y%m%d") if request_parameters[:start_date]
        parsed[:enddate] = request_parameters[:end_date].strftime("%Y%m%d") if request_parameters[:end_date]
        parsed[:extended] = (request_parameters[:extended] == false ? 'false' : 'true') if request_parameters[:extended]
        return parsed
      end

      def required_params
        [:source, :request_value, :interval_type, :interval_duration]
      end

      def optional_params
        [:period_type, :period, :start_date, :end_date, :extended, :session]
      end

      def default_parameters
        {:request_identifier_type => 'SYMBOL'}
      end

      def handle_response data
        parser = AMTD::Parsers::PriceHistory.new(StringIO.new(data))
        @response = parser.parse
        return @response
      end

      def error?
        @response[:result] == 'FAIL'
      end

      def endpoint_path
        '/100/PriceHistory'
      end

      def headers
        if @session
          default_headers.merge({'Set-Cookie' => "JSESSIONID=#{@session}"})
        end
      end

      def validate_period_type! value
        return if value.nil?
        raise ArgumentError, "Period type and start date are mutually exclusive" if request_parameters[:start_date]
        raise ArgumentError, "Invalid period type #{value} - posible values: #{PERIOD_TYPES}" unless PERIOD_TYPES.include?(value)
      end

      def validate_period! value
        return if value.nil?
        raise ArgumentError, "Period and start date are mutually exclusive" if request_parameters[:start_date]
        period_type = request_parameters[:period_type]
        raise ArgumentError, "Invalid period #{value} for #{period_type} - posible values: #{PERIOD_VALUES[period_type]}" unless PERIOD_VALUES[period_type].include?(value)
      end

      def validate_interval_type! value
        return if value.nil?
        period_type = request_parameters[:period_type]
        raise ArugmentError, "Invalid interval type #{value} for #{period_type} - posible values: #{INTERVAL_TYPES}" unless INTERVAL_TYPES.include?(value)
      end

      def validate_interval_duration! value
        return if value.nil?
        interval_type = request_parameters[:interval_type]
        raise ArgumentError, "Invalid interval duration #{value} for #{interval_type} - posible values: #{INTERVAL_DURATIONS[interval_type]}" unless INTERVAL_DURATIONS[interval_type].include?(value)
      end

      def validate_start_date! value
        return if value.nil?
        raise ArgumentError, "Period type and start date are mutually exclusive" if request_parameters[:period_type]
        raise ArgumentError, "Expected Date instead of #{value.class} for start_date" unless value.is_a?(Date)
      end

      def validate_end_date! value
        return if value.nil?
        raise ArgumentError, "Expected Date instead of #{value.class} for end_date" unless value.is_a?(Date)
      end

      def validate_endpoint_params!
        validate_interval_type! request_parameters[:interval_type]
        validate_interval_duration! request_parameters[:interval_duration]
        validate_period_type! request_parameters[:period_type]
        validate_period! request_parameters[:period]
        validate_start_date! request_parameters[:start_date]
        validate_end_date! request_parameters[:end_date]
      end
    end

  end
end
