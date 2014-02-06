require File.expand_path("bitcoin-client", File.dirname(__FILE__))

module Bitcoin
  autoload :Client, 'bitcoin-client/client'
  autoload :API,    'bitcoin-client/api'
  autoload :Request,'bitcoin-client/request'
  autoload :RPC,    'bitcoin-client/rpc'
  autoload :Errors, 'bitcoin-client/errors'
  autoload :Version,'bitcoin-client/version'
  autoload :VERSION,'bitcoin-client/version'
  autoload :DSL,    'bitcoin-client/dsl'
  
  def self.included(base)
    base.send(:include, Bitcoin::DSL)
    base.send(:extend,  Bitcoin::DSL)
  end
end

def Bitcoin(user, pass, options = {})
  ::Bitcoin::Client.new(user, pass, options)
end
