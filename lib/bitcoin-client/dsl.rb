module BitcoinClient::DSL
  def bitcoin
    if self.class.respond_to?(:bitcoin)
      @client ||= BitcoinClient::Client.new(self.class.bitcoin.user, self.class.bitcoin.pass, self.class.bitcoin.options)
    else
      @client ||= BitcoinClient::Client.new(nil, nil)
    end
  end
  
  def username=(value)
    bitcoin.user = value
  end
  
  def password=(value)
    bitcoin.pass = value
  end
  
  def host=(value)
    bitcoin.host = value
  end
  
  def port=(value)
    bitcoin.port = value
  end
  
  def ssl=(value)
    bitcoin.ssl = value
  end
  
  def username(value = nil)
    value ? bitcoin.user = value : bitcoin.user
  end
  
  def password(value = nil)
    value ? bitcoin.pass = value : bitcoin.pass
  end
  
  def host(value = nil)
    value ? bitcoin.host = value : bitcoin.host
  end
  
  def port(value = nil)
    value ? bitcoin.port = value : bitcoin.port
  end
  
  def ssl(value = nil)
    value.nil? ? bitcoin.ssl : bitcoin.ssl = value
  end
  
  def ssl?
    bitcoin.ssl?
  end
  
  
  # Safely copies wallet.dat to destination, which can be a directory or a path with filename. 
  def backupwallet(destination)
    bitcoin.backupwallet destination
  end
  
  # Returns the account associated with the given address. 
  def getaccount(bitcoinaddress)
    bitcoin.getaccount bitcoinaddress
  end
  
  # Returns the current bitcoin address for receiving payments to this account. 
  def getaccountaddress(account)
    bitcoin.getaccountaddress account
  end
  
  #	Returns the list of addresses for the given account. 
  def getaddressesbyaccount(account)
    bitcoin.getaddressesbyaccount account
  end
  
  # If +account+ is not specified, returns the server's total available balance.
  # If +account+ is specified, returns the balance in the account.
  def getbalance(account = nil, minconf = 1)
    bitcoin.getbalance account, minconf
  end

  # Returns the hash of the best (tip) block in the longest block chain.
  def getbestblockhash
    bitcoin.getbestblockhash
  end
  
  # Dumps the block existing at specified height.
  # Note: this is not available in the official release
  def getblockbycount(height)
    bitcoin.getblockbycount height
  end
  
  # Dumps the block existing with specified hash.
  def getblock(hash)
    bitcoin.getblock hash
  end

  # Returns the number of blocks in the longest block chain.
  def getblockcount
    bitcoin.getblockcount
  end
  
  # Returns the block number of the latest block in the longest block chain. 
  def getblocknumber
    bitcoin.getblocknumber
  end

  # Returns hash of block in best-block-chain at <index>; index 0 is the genesis block
  def getblockhash(index)
    bitcoin.getblockhash index
  end
  
  # Returns the number of connections to other nodes.
  def getconnectioncount
    bitcoin.getconnectioncount
  end
  
  # Returns the proof-of-work difficulty as a multiple of the minimum difficulty. 
  def getdifficulty
    bitcoin.getdifficulty
  end
  
  # Returns true or false whether bitcoind is currently generating hashes 
  def getgenerate
    bitcoin.getgenerate
  end
  
  # Returns a recent hashes per second performance measurement while generating. 
  def gethashespersec
    bitcoin.gethashespersec
  end

  # Returns an object containing various state info. 
  def getinfo
    bitcoin.getinfo
  end

  # Returns data about each connected network node.
  def getpeerinfo
    bitcoin.getpeerinfo
  end

  # Returns an object containing various mining info.
  def getmininginfo
    bitcoin.getmininginfo
  end

  # Returns a new bitcoin address for receiving payments. If +account+ is specified (recommended),
  # it is added to the address book so payments received with the address will be credited to +account+.
  def getnewaddress(account = nil)
    bitcoin.getnewaddress account
  end
  
  # Returns the total amount received by addresses with +account+ in transactions
  # with at least +minconf+ confirmations. 
  def getreceivedbyaccount(account, minconf = 1)
    bitcoin.getreceivedbyaccount account, minconf
  end
  
  # Returns the total amount received by +bitcoinaddress+ in transactions with at least +minconf+ confirmations. 
  def getreceivedbyaddress(bitcoinaddress, minconf = 1)
    bitcoin.getreceivedbyaddress bitcoinaddress, minconf
  end
  
  # Get detailed information about +txid+ 
  def gettransaction(txid)
    bitcoin.gettransaction txid
  end
  

  # Get raw transaction bout +txid+. It outputs the whole transaction chain by default in HEX. If you want JSON, set verbose to 1.
  # When in the bitcoind config is set txindex=1, after reindexing, you can ask about any transaction (not included in your wallet), with this command.
  def getrawtransaction(txid, verbose = 0)
    bitcoin.getrawtransaction txid verbose
  end

  # Gets all mempool txs (pedning/waiting to be added in a block)
  def getrawmempool
    bitcoin.getrawmempool
  end

  # If +data+ is not specified, returns formatted hash data to work on:
  #
  #  :midstate => precomputed hash state after hashing the first half of the data
  #  :data     => block data
  #  :hash1    => formatted hash buffer for second hash
  #  :target   => little endian hash target 
  #
  # If +data+ is specified, tries to solve the block and returns true if it was successful.
  def getwork(data = nil)
    bitcoin.getwork data
  end
  
  # List commands, or get help for a command. 
  def help(command = nil)
    bitcoin.help command
  end
  
  # Returns Object that has account names as keys, account balances as values. 
  def listaccounts(minconf = 1)
    bitcoin.listaccounts minconf
  end
  
  # Returns an array of objects containing:
  # 
  #   :account       => the account of the receiving addresses
  #   :amount        => total amount received by addresses with this account
  #   :confirmations => number of confirmations of the most recent transaction included
  #
  def listreceivedbyaccount(minconf = 1, includeempty = false)
    bitcoin.listreceivedbyaccount minconf, includeempty
  end
  
  # Returns an array of objects containing:
  # 
  #   :address       => receiving address
  #   :account       => the account of the receiving address
  #   :amount        => total amount received by the address
  #   :confirmations => number of confirmations of the most recent transaction included 
  # 
  # To get a list of accounts on the system, execute bitcoind listreceivedbyaddress 0 true
  def listreceivedbyaddress(minconf = 1, includeempty = false)
    bitcoin.listreceivedbyaddress minconf, includeempty
  end
  
  # Returns up to +count+ most recent transactions for account +account+. 
  def listtransactions(account = '', count = 10, from = 0)
    bitcoin.listtransactions account, count, from
  end
  
  # Move from one account in your wallet to another. 
  def move(fromaccount, toaccount, amount, minconf = 1, comment = nil)
    bitcoin.move fromaccount, toaccount, amount, minconf, comment
  end

  # Return count transactions with <address> present in their scriptSig, skipping skip at the beginning. The ordering is oldest transaction first; if skip is negative the order returned is newest transaction first and skip+1 transactions are skipped. If verbose=0 only txids are returned rather than the full transactions.
  def searchrawtransactions(bitcoinaddress, verbose=1)
    bitcoin.searchrawtransactions bitcoinaddress, verbose
  end
  
  # +amount+ is a real and is rounded to 8 decimal places. Returns the transaction ID if successful. 
  def sendfrom(fromaccount, tobitcoinaddress, amount, minconf = 1, comment = nil, comment_to = nil)
    bitcoin.sendfrom fromaccount, tobitcoinaddress, amount, minconf, comment, comment_to
  end
  
  # +amount+ is a real and is rounded to 8 decimal places 
  def sendtoaddress(bitcoinaddress, amount, comment = nil, comment_to = nil)
    bitcoin.sendtoaddress bitcoinaddress, amount, comment, comment_to
  end
  
  # Sets the account associated with the given address. 
  def setaccount(bitcoinaddress, account)
    bitcoin.setaccount bitcoinaddress, account
  end
  
  # +generate+ is true or false to turn generation on or off.
  # Generation is limited to +genproclimit+ processors, -1 is unlimited.
  def setgenerate(generate, genproclimit = -1)
    bitcoin.setgenerate generate, genproclimit
  end
  
  # Stop bitcoin server. 
  def stop
    bitcoin.stop
  end
  
  # Return information about +bitcoinaddress+. 
  def validateaddress(bitcoinaddress)
    bitcoin.validateaddress
  end
  
  alias account getaccount
  alias account_address getaccountaddress
  alias addresses_by_account getaddressesbyaccount
  alias balance getbalance
  alias block_by_count getblockbycount
  alias block_count getblockcount
  alias block_number getblocknumber
  alias block_hash getblockhash
  alias connection_count getconnectioncount
  alias difficulty getdifficulty
  alias generate? getgenerate
  alias hashes_per_sec gethashespersec
  alias info getinfo
  alias peerinfo getpeerinfo
  alias mininginfo getmininginfo
  alias new_address getnewaddress
  alias received_by_account getreceivedbyaccount
  alias received_by_address getreceivedbyaddress
  alias transaction gettransaction
  alias rawtransaction getrawtransaction  
  alias work getwork
  alias get_work getwork
  alias accounts listaccounts
  alias list_received_by_account listreceivedbyaccount
  alias list_received_by_address listreceivedbyaddress
  alias transactions listtransactions
  alias list_transactions listtransactions
  alias send_from sendfrom
  alias send_to_address sendtoaddress
  alias account= setaccount
  alias set_account setaccount
  alias generate= setgenerate
  alias set_generate setgenerate
  alias validate_address validateaddress
  alias search_raw_transactions searchrawtransactions
  alias raw_mempool getrawmempool
end
