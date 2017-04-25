require 'spec_helper'

describe AMTD::Endpoints::Login do
  before do
    configure_gem!
    @adapter = AMTD::Adapter.new
  end

  describe '#execute!' do
    before do
      @params = {:user_id => '123', :password => 'asd', :source => 'test'}
      @endpoint = AMTD::Endpoints::Login.new(@adapter, @params)
    end

    it 'returns data' do
      data = File.read(fixture_path.join('login', 'example.xml'))
      allow(@adapter).to receive(:post).and_return(data)
      @endpoint.execute!
      expect(@endpoint.response).not_to eq(nil)
    end

    it 'raises error when unauthorized error received' do
      data = File.read(fixture_path.join('login', 'unauthorized_error.xml'))
      allow(@adapter).to receive(:post).and_return(data)
      expect(Proc.new{@endpoint.execute!}).to raise_error(AMTD::Errors::Login::Unauthorized)
    end

    it 'raises error when incorrect params error received' do
      data = File.read(fixture_path.join('login', 'url_param_error.xml'))
      allow(@adapter).to receive(:post).and_return(data)
      expect(Proc.new{@endpoint.execute!}).to raise_error(AMTD::Errors::Login::LoginFailed)
    end
  end

  describe '#initialize' do
    it 'rasies error if no adapter is provided' do
      expect(Proc.new{AMTD::Endpoints::Login.new}).to raise_error(ArgumentError)
    end

    it 'raises error if no params provided' do
      expect(Proc.new{AMTD::Endpoints::Login.new(@adapter)}).to raise_error(ArgumentError)
    end

    it 'does not raise error if all in place' do
      params = {:user_id => '123', :password => 'qwe', :source => 'asd'}
      expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).not_to raise_error
    end

    context 'params' do
      it 'raises error if user_id is missing' do
        params = {:password => 'qwe', :source => 'asd'}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        params = {:user_id => '', :password => 'qwe', :source => 'asd'}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        params = {:user_id => nil, :password => 'qwe', :source => 'asd'}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
      end

      it 'raises error if password is missing' do
        params = {:user_id => 'qwe', :source => 'asd'}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        params = {:user_id => 'asd', :password => '', :source => 'asd'}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        params = {:user_id => 'asd', :password => nil, :source => 'asd'}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
      end

      it 'raises error if source is missing' do
        params = {:password => 'qwe', :user_id => 'asd'}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        params = {:user_id => '', :password => 'qwe', :source => ''}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
        params = {:user_id => nil, :password => 'qwe', :source => nil}
        expect(Proc.new{AMTD::Endpoints::Login.new(@adapter, params)}).to raise_error(AMTD::Errors::Endpoint::MissingParameter)
      end
    end
  end
end
