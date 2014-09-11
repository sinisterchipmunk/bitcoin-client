require 'spec_helper'

describe BitcoinClient::Client do
  subject { BitcoinClient::Client.new($user, $pass) }

  it "defaults" do
    subject.user.should == $user
    subject.pass.should == $pass
    subject.host.should == 'localhost'
    subject.port.should == 8332
    subject.should_not be_ssl
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

    service 'getmininginfo' do
      it "should produce the expected result" do
        result.should == {
          'blocks' => 237338,
          'currentblocksize' => 0,
          'currentblocktx' => 0,
          'difficulty' => 11187257.46136079,
          'errors' => "",
          'generate' => false,
          'genproclimit' => -1,
          'hashespersec' => 0,
          'pooledtx' => 0,
          'testnet' => false
        }
      end
    end

    service 'getblock' do
      it "should produce the expected result" do
        result("0000000000000002e004985f39f929d001448623b312185bf5e4ab50e5a8e60a").should == {
          'hash' => "0000000000000002e004985f39f929d001448623b312185bf5e4ab50e5a8e60a",
          'confirmations' => 19,
          'size' => 5227,
          'height' => 240707,
          'version' => 2,
          'merkleroot' => "18b914e2d6bd4c3118a936af75afbd230611edb6929a607302c0d591ef49b24e",
          'tx' => [
            "cutforsimplicity",
            "27f99033bdcea87b07f8eea4279d7ce24e479fcb49e9f54e9ffb3721e29838ed"
          ],
          'time' => Time.utc(2013, 6, 10, 5, 40, 3),
          'nonce' => 3937756309,
          "bits" => "1a011337",
          "difficulty" => 15605632.68128593,
          "previousblockhash" => "000000000000003fa76b2abdd3036d183d7e24cfb6b543781d59cdca289f6053",
          "nextblockhash" => "0000000000000087a1e962f618f757393930e58a745165033fc9d281b7bb568a"
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
        result.should == false
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

    service 'setaccount' do
      it 'maps the call correctly' do
        subject.api.should_receive(:request).with(*%w(setaccount bitcoinaddress account))
        result('bitcoinaddress', 'account').should be_nil
      end
    end

    service 'signmessage' do
      context 'success' do
        it "should produce the expected result" do
          result('valid_address', 'message').should == 'Gwz2BAaqdsLTqJsh5a4'
        end
      end

      context 'invalid address' do
        it "should produce the expected result" do
          lambda { result('invalid_address', 'message').should }.should \
            raise_error BitcoinClient::Errors::RPCError
        end
      end
    end

    service 'verifymessage' do
      context 'success' do
        it "should produce the expected result" do
          result('address', 'message', 'signature').should == true
        end
      end

      context 'failure' do
        it "should produce the expected result" do
          result('address', 'message', 'signature').should == false
        end
      end
    end
  end
end
