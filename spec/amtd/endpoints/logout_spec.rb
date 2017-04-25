require 'spec_helper'

describe AMTD::Endpoints::Logout do
  before do
    configure_gem!
    @adapter = AMTD::Adapter.new
    @default_params = {:source => 'asd'}
  end

  describe '#execute!' do
    before do
      @endpoint = AMTD::Endpoints::Logout.new(@adapter, @default_params)
    end

    it 'returns data' do
      data = File.read(fixture_path.join('logout', 'example.xml'))
      allow(@adapter).to receive(:post).and_return(data)
      @endpoint.execute!
      expect(@endpoint.response).not_to eq(nil)
    end
  end

  describe '#initialize' do
    it 'rasies error if no adapter is provided' do
      expect(Proc.new{AMTD::Endpoints::Logout.new}).to raise_error(ArgumentError)
    end

    it 'raises error if no params provided' do
      expect(Proc.new{AMTD::Endpoints::Logout.new(@adapter)}).to raise_error(ArgumentError)
    end

    it 'does not raise error if all in place' do
      expect(Proc.new{AMTD::Endpoints::Logout.new(@adapter, @default_params)}).not_to raise_error
    end

    context 'params' do
      it 'raises error if source is missing' do
        @default_params.delete :source
        expect(Proc.new{AMTD::Endpoints::Logout.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        @default_params[:source] = nil
        expect(Proc.new{AMTD::Endpoints::Logout.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        @default_params[:source] = ''
        expect(Proc.new{AMTD::Endpoints::Logout.new(@adapter, @default_params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
      end

    end
  end
end
