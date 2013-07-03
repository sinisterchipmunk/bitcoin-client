require 'spec_helper'

describe BitcoinClient::API do
  subject { BitcoinClient::API.new(:user => $user, :pass => $pass) }
  
  it "should have default host, port, ssl" do
    subject.host.should == 'localhost'
    subject.port.should == 8332
    subject.ssl?.should be_false
  end
  
  it "should accept host, port, ssl options" do
    req = BitcoinClient::API.new(:user => $user, :pass => $pass, :host => 'example.com', :port => 1234, :ssl => true)
    req.host.should == 'example.com'
    req.port.should == 1234
    req.ssl?.should be_true
  end
  
  it "should build an options hash" do
    subject.to_hash.should == {
      :user => $user,
      :pass => $pass,
      :host => 'localhost',
      :port => 8332,
      :ssl => false,
    }
  end
end
