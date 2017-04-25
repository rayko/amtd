require 'amtd'
require 'pry'
require 'timecop'

def configure_gem!
  AMTD.configure do |config|
    config.source = 'test'
  end
end

def fixture_path
  Pathname.new('spec/fixtures')
end
