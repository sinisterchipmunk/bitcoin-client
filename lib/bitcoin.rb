module Bitcoin
  autoload :Client, 'bitcoin/client'
  autoload :API,    'bitcoin/api'
  autoload :Request,'bitcoin/request'
  autoload :RPC,    'bitcoin/rpc'
  autoload :Errors, 'bitcoin/errors'
  autoload :Version,'bitcoin/version'
  autoload :VERSION,'bitcoin/version'
  autoload :DSL,    'bitcoin/dsl'
  
  def self.included(base)
    base.send(:include, Bitcoin::DSL)
    base.send(:extend,  Bitcoin::DSL)
  end
end

def Bitcoin(user, pass, options = {})
  ::Bitcoin::Client.new(user, pass, options)
end
