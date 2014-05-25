module BitcoinClient
  autoload :Client, 'bitcoin-client/client'
  autoload :API,    'bitcoin-client/api'
  autoload :Request,'bitcoin-client/request'
  autoload :RPC,    'bitcoin-client/rpc'
  autoload :Errors, 'bitcoin-client/errors'
  autoload :Version,'bitcoin-client/version'
  autoload :VERSION,'bitcoin-client/version'
  autoload :DSL,    'bitcoin-client/dsl'
  
  def self.included(base)
    base.send(:include, BitcoinClient::DSL)
    base.send(:extend,  BitcoinClient::DSL)
  end
end

def BitcoinClient(user, pass, options = {})
  ::BitcoinClient::Client.new(user, pass, options)
end
