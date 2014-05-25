module BitcoinClient
  autoload :Client, 'bitcoin_client/client'
  autoload :API,    'bitcoin_client/api'
  autoload :Request,'bitcoin_client/request'
  autoload :RPC,    'bitcoin_client/rpc'
  autoload :Errors, 'bitcoin_client/errors'
  autoload :Version,'bitcoin_client/version'
  autoload :VERSION,'bitcoin_client/version'
  autoload :DSL,    'bitcoin_client/dsl'
  
  def self.included(base)
    base.send(:include, BitcoinClient::DSL)
    base.send(:extend,  BitcoinClient::DSL)
  end
end

def BitcoinClient(user, pass, options = {})
  ::BitcoinClient::Client.new(user, pass, options)
end
