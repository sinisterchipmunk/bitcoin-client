require 'spec_helper'

describe Bitcoin::Client do
  subject { Bitcoin::Client.new($user, $pass) }
  
  it "defaults" do
    subject.user.should == $user
    subject.pass.should == $pass
    subject.host.should == 'localhost'
    subject.port.should == 8332
    subject.ssl?.should_not be_true
  end
  
  context "RPC" do
    extend RPCServiceHelper
    
    service 'getinfo' do
      it "should produce the expected result" do
        result.should == {
          'version' => 32400,
          'balance' => 0.001,
          'blocks' => 141957,
          'connections' => 8,
          'proxy' => "",
          'generate' => false,
          'genproclimit' => -1,
          'difficulty' => 1805700.83619367,
          'hashespersec' => 0,
          'testnet' => false,
          'keypoololdest' => 1313766189,
          'paytxfee' => 0.0,
          'errors' => ""
        }
      end
    end
    
    service 'getblockcount' do
      it "should produce the expected result" do
        result.should == 141972
      end
    end

    service 'getblocknumber' do
      it "should produce the expected result" do
        result.should == 141972
      end
    end
    
    service 'getconnectioncount' do
      it "should produce the expected result" do
        result.should == 8
      end
    end
    
    service 'getdifficulty' do
      it "should produce the expected result" do
        result.should == 1805700.83619367
      end
    end
    
    service 'getgenerate' do
      it "should produce the expected result" do
        result.should be_false
      end
    end
    
    service 'gethashespersec' do
      it "should produce the expected result" do
        result.should == 0
      end
    end
    
    service 'listreceivedbyaddress' do
      context 'without params' do
        it "should produce the expected result" do
          result.should == [{
            'address' => "1234",
            'account' => "", 
            'label' => "",
            'amount' => 0.001, 
            'confirmations' => 180}]
        end
      end
      
      context 'with minconf 0' do
        it "should produce the expected result" do
          result(0).should == [{
            'address' => "1234",
            'account' => "", 
            'label' => "",
            'amount' => 0.001, 
            'confirmations' => 180}]
        end
      end

      context 'with minconf 0 and includeempty true' do
        it "should produce the expected result" do
          result(0, true).should == [{
            'address' => "1234",
            'account' => "", 
            'label' => "",
            'amount' => 0.001, 
            'confirmations' => 180}]
        end
      end
    end
  end
end
