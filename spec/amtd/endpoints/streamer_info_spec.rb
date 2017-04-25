require 'spec_helper'

describe AMTD::Endpoints::StreamerInfo do
  before do
    configure_gem!
    @adapter = AMTD::Adapter.new
    @default_params = {:source => 'asd', :account_id => '123'}
  end

  describe '#execute!' do
    before do
      @endpoint = AMTD::Endpoints::StreamerInfo.new(@adapter, @default_params)
    end

    it 'returns data' do
      data = File.read(fixture_path.join('streamer_info', 'example.xml'))
      allow(@adapter).to receive(:get).and_return(data)
      @endpoint.execute!
      expect(@endpoint.response).not_to eq(nil)
    end

    it 'raises error when not allowed error received' do
      data = File.read(fixture_path.join('streamer_info', 'not_allowed_error.xml'))
      allow(@adapter).to receive(:get).and_return(data)
      expect(Proc.new{@endpoint.execute!}).to raise_error(AMTD::Errors::StreamerInfo::NotAllowed)
    end

    it 'raises error when invalid session error received' do
      data = File.read(fixture_path.join('streamer_info', 'invalid_session_error.xml'))
      allow(@adapter).to receive(:get).and_return(data)
      expect(Proc.new{@endpoint.execute!}).to raise_error(AMTD::Errors::StreamerInfo::InvalidSession)
    end
  end

  describe '#initialize' do
    it 'rasies error if no adapter is provided' do
      expect(Proc.new{AMTD::Endpoints::StreamerInfo.new}).to raise_error(ArgumentError)
    end

    it 'raises error if no params provided' do
      expect(Proc.new{AMTD::Endpoints::StreamerInfo.new(@adapter)}).to raise_error(ArgumentError)
    end

    it 'does not raise error if all in place' do
      expect(Proc.new{AMTD::Endpoints::StreamerInfo.new(@adapter, @default_params)}).not_to raise_error
    end

    context 'params' do
      it 'raises error if source is missing' do
        @default_params.delete :source
        expect(Proc.new{AMTD::Endpoints::StreamerInfo.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        @default_params[:source] = nil
        expect(Proc.new{AMTD::Endpoints::StreamerInfo.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        @default_params[:source] = ''
        expect(Proc.new{AMTD::Endpoints::StreamerInfo.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
      end

    end
  end
end
