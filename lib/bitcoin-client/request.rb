require 'json'

class BitcoinClient::Request
  attr_reader :service_name, :params
  
  def initialize(service_name, params = [])
    @service_name = service_name
    @params = params.dup
    
    # bitcoin rejects null values even for optional params. Since
    # even params following those may have default non-nil values,
    # we'll assume the first non-nil value marks a set of optional
    # params, and drop it and everything following it.
    #
    # ex:
    #   [nil]          => []
    #   [1,nil,nil]    => [1]
    #   [1,nil,nil,1]  => [1]
    if index = @params.index(nil)
      @params = @params[0...index]
    end
  end
  
  def to_hash
    {
      :method => service_name,
      :params => params,
      :id => "jsonrpc"
    }
  end
  
  def to_post_data
    to_hash.to_json
  end
end
