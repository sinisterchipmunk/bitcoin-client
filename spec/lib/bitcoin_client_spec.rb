require 'spec_helper'

describe BitcoinClient do
  before :each do
    FakeWeb.register_uri(:post, "http://user:pass@localhost:8332", :response => fixture('getbalance'))
  end
  
  it "as a function" do
    cli = BitcoinClient($user, $pass)
    cli.balance.should == 0.001
  end
  
  it "DSL, included" do
    class << self
      include BitcoinClient
    end
    
    username $user
    password $pass
    
    balance.should == 0.001
  end
  
  it "DSL, extended" do
    class << self
      include BitcoinClient
      
      username $user
      password $pass
      
      balance.should == 0.001
    end
  end
end
