require 'spec_helper'

describe "server" do
  after(:all) do
    CarbonMU.shutdown
  end
  before(:all) do
    CarbonMU.start_in_background
    sleep(2)
  end

  it 'accepts connections' do
    s = TCPSocket.new'localhost', 8421
    s.readpartial(4096).should match(/Connected/)
  end
end
