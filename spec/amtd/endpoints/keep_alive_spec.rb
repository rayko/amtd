require 'spec_helper'

describe AMTD::Endpoints::KeepAlive do
  before do
    configure_gem!
    @adapter = AMTD::Adapter.new
    @default_params = {:source => 'asd'}
  end

  describe '#execute!' do
    before do
      @endpoint = AMTD::Endpoints::KeepAlive.new(@adapter, @default_params)
    end

    it 'returns data' do
      data = File.read(fixture_path.join('keep_alive', 'example.text'))
      allow(@adapter).to receive(:post).and_return(data.strip)
      @endpoint.execute!
      expect(@endpoint.response).not_to eq(nil)
    end

    it 'raises error when invalid session error is received' do
      data = File.read(fixture_path.join('keep_alive', 'invalid_session.text'))
      allow(@adapter).to receive(:post).and_return(data.strip)
      expect(Proc.new{@endpoint.execute!}).to raise_error(AMTD::Errors::KeepAlive::InvalidSession)
    end
  end

  describe '#initialize' do
    it 'rasies error if no adapter is provided' do
      expect(Proc.new{AMTD::Endpoints::KeepAlive.new}).to raise_error(ArgumentError)
    end

    it 'raises error if no params provided' do
      expect(Proc.new{AMTD::Endpoints::KeepAlive.new(@adapter)}).to raise_error(ArgumentError)
    end

    it 'does not raise error if all in place' do
      expect(Proc.new{AMTD::Endpoints::KeepAlive.new(@adapter, @default_params)}).not_to raise_error
    end

    context 'params' do
      it 'raises error if source is missing' do
        @default_params.delete :source
        expect(Proc.new{AMTD::Endpoints::KeepAlive.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        @default_params[:source] = nil
        expect(Proc.new{AMTD::Endpoints::KeepAlive.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        @default_params[:source] = ''
        expect(Proc.new{AMTD::Endpoints::KeepAlive.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
      end

    end
  end
end
